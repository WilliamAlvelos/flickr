//
//  ImageCache.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private var cache: [URL: UIImage] = [:]

    private init() {}

    func getImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache[url] {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                self.cache[url] = image

                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
