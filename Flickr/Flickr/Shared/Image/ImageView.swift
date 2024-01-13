//
//  ImageView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL?
    var contentMode: ContentMode = .fit
    
    @State private var cachedImage: UIImage? = nil
    @State private var isLoading: Bool = false
    @State private var error: Error?
    

    var body: some View {
        VStack {
            if let cachedImage = cachedImage {
                Image(uiImage: cachedImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                if isLoading {
                    ProgressView()
                } else if let imageURL = imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: contentMode)
                        case .failure:
                            Button("", systemImage: "arrow.circlepath", action: loadImage)
                                .foregroundColor(.blue)
                        @unknown default:
                            Button("", systemImage: "arrow.circlepath", action: loadImage)
                                .foregroundColor(.blue)
                        }
                    }.onAppear(perform: loadImage)
                }
            }
        }
    }
        
    private func loadImage() {
          guard let imageURL = imageURL else { return }
          isLoading = true

          URLSession.shared.dataTask(with: imageURL) { data, response, error in
              DispatchQueue.main.async {
                  isLoading = false
                  if let data = data, let loadedImage = UIImage(data: data) {
                      cachedImage = loadedImage
                  } else {
                      self.error = error
                  }
              }
          }.resume()
      }
    
}
    
