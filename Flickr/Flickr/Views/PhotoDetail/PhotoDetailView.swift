//
//  PhotoDetailView.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

struct PhotoDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var photo: Photo
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .topTrailing) {
                    PhotoView(photo: photo,
                              screenWidth: geometry.size.width, 
                              userPhotoTapGesture: nil)
                    
                    VStack(spacing: 16) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primaryBlue)
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                        }
                    }
                    .padding(16)
                }
            }
            
            // TODO:  DISPLAY PHOTO COMMENTS
            Text(photo.id)
        }
    }
}
