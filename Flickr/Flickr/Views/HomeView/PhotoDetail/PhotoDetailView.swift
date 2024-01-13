//
//  PhotoDetailView.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: Photo
    
    var body: some View {
        Text(photo.title)
    }
}
