//
//  GroupDetail.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct GroupDetail: View {
    let group: Group
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    ZStack {
                        ImageView(imageURL: group.coverphotoUrl.url)
                            .frame(width: geometry.size.width)
                        
                        ImageView(imageURL: group.iconURL)
                            .frame(width: 100, height: 100)
                            .personImageViewModifier()
                    }
                }
                
                VStack {
                    HStack {
                        Text(group.name)
                            .font(.title)
                        
                        if group.eighteenplus.boolValue {
                            Text("🔞")
                                .font(.title)
                        }
                    }
                    
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
                    Spacer()

                    Button { } label: {
                        Text("+ Join")
                    }.buttonStyle(FlickrButtonStyle())
                }.padding()
            }
        }.navigationTitle(group.name)
    
    }
}
