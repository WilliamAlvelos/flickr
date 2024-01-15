//
//  PhotoView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct PhotoView: View {
    let photo: Photo
    let screenWidth: CGFloat
    let userPhotoTapGesture: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageView(imageURL: photo.photoURL)
                .frame(width: screenWidth)
                .clipped()
            
            TagsView(tags: photo.resumedPhotoTags)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            HStack(alignment: .center) {
                ImageView(imageURL: photo.iconURL)
                    .frame(width: 40, height: 40)
                    .personImageViewModifier()
                
                VStack(alignment: .leading) {
                    Text(photo.title)
                        .font(.headline)
                        .lineLimit(2)
                    Text(photo.ownername)
                        .font(.footnote)
                }
                
                Spacer()
                
                Text(photo.dateTakesFormated)
                    .font(.footnote)
                    .padding()
            }.onTapGesture {
                userPhotoTapGesture?()
            }
        }
    }
}
