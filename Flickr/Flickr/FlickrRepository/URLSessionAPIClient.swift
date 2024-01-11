//
//  URLSessionAPIClient.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

protocol Requestable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String] { get }
    var body: Encodable? { get }
}

struct Request: Requestable {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var headers: [String: String]?
    var parameters: [String: String]
    var body: Encodable?
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
    case unauthorized
}

struct FlickrError: Codable, Error {
    let message: String
}

protocol APIClient {
    func request<T: Decodable>(_ endpoint: Requestable) -> AnyPublisher<T, Error>
}

class URLSessionAPIClient: APIClient {
    
    let commomParams = ["format": "json",
                        "nojsoncallback": "1",
                        "api_key": APIKeys.apiKey()]

    func request<T: Decodable>(_ endpoint: Requestable) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let endpointQueryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        let commonQueryItems = commomParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        urlComponents.queryItems = endpointQueryItems + commonQueryItems
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = endpoint.method.rawValue
                        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        FlickrLogger.logRequest(request: request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                
                FlickrLogger.logResponse(data: data, response: response)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    
                    if [401, 403].contains(httpResponse.statusCode) {
                        throw APIError.unauthorized
                    }
                    
                    throw try JSONDecoder().decode(FlickrError.self, from: data)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
