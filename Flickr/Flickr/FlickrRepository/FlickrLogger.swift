//
//  FlickrLogger.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

final class FlickrLogger {
    
    private static let isLogEnabled: Bool = true
    
    static func logRequest(request: URLRequest) {
        guard isLogEnabled else { return }
        
        print("-------------------- REQUEST --------------------")
        print(request)
        print("-------------------------------------------------")
    }
    
    static func logResponse(data: Data, response: URLResponse) {
        guard isLogEnabled else { return }
        
        print("-------------------- RESPONSE --------------------")
        print(response)
        guard let responseData = String(data: data, encoding: .utf8) else { return }
        print(responseData)
        print("--------------------------------------------------")
    }
}
