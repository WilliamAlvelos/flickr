//
//  ImageView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL?
    
    @State private var cachedImage: UIImage? = nil

    var body: some View {
        VStack {
            if let cachedImage = cachedImage {
                Image(uiImage: cachedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                if let imageURL = imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Text("Failed to load image")
                                .foregroundColor(.red)
                        @unknown default:
                            Text("Unknown state")
                        }
                    }
                }
            }
        }
    }
}
