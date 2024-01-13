//
//  TagsView.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

struct TagsView: View {
    var tags: [Tag]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(tags) { tag in
                Text(tag.name)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .bold()
                    .padding(8)
                    .background(Color.secondaryPink.gradient)
                    .clipShape(Capsule())
                    .lineLimit(1)
            }
        }
    }
}


