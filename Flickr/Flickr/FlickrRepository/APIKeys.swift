//
//  APIKeys.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

class APIKeys {
    static func apiKey() -> String? {
        if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") {
            guard let dict = NSDictionary(contentsOfFile: path) else { return nil }
            return dict.value(forKey: "api_key") as? String
        }
        return nil
    }
}
