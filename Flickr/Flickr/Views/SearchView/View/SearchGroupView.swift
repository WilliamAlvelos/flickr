//
//  SearchGroupView.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct SearchGroupView: View {
    let group: Group
    
    var body: some View {
        
        HStack {
            ImageView(imageURL: group.iconURL)
                .frame(width: 50, height: 50)
                .personImageViewModifier()
            
            VStack(alignment: .leading , spacing: 10) {
                Text(group.name)
                    .font(.headline)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "person.3.fill")
                    Text(group.members)
                        .font(.footnote)
                        .bold()
                    
                    Image(systemName: "message.fill")
                    Text(group.topicCount)
                        .font(.footnote)
                        .bold()

                    Image(systemName: "photo.on.rectangle")
                    Text(group.poolCount)
                        .font(.footnote)
                        .bold()
                }
            }
            
            Spacer()
            
            if group.eighteenplus.boolValue {
                Text("🔞")
                    .font(.headline)
            }
        }
    }
}

