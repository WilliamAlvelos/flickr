//
//  PhotoView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct PhotoView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    let photo: Photo
    let screenWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageView(imageURL: photo.photoURL, contentMode: .fill)
                .frame(width: screenWidth)
                .clipped()
            
            TagsView(tags: photo.photoTags)
            
            HStack {
                ImageView(imageURL: photo.ownerPhotoURL)
                    .frame(width: 40, height: 40)
                    .personImageViewModifier()
                    .onTapGesture {
                        coordinator.presentUserProfile(owner: photo.owner)
                    }
                
                VStack(alignment: .leading) {
                    Text(photo.title)
                        .font(.headline)
                        .lineLimit(2)
                    Text(photo.ownername)
                        .font(.footnote)
                }
            }
        }
    }
}
