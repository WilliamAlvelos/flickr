//
//  ProfileView.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import SwiftUI

struct ProfileView: View {
    let person: Person
    let screenWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                ImageView(imageURL: person.coverPhotoURL, contentMode: .fill)
                    .frame(width: screenWidth)
                
                ImageView(imageURL: person.ownerPhotoURL)
                    .frame(width: 100, height: 100)
                    .personImageViewModifier()
            }
            
            HStack {
                Text(person.username._content)
                    .font(.callout)
                
                if person.ispro == 1 {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.secondaryPink)
                }
            }
            
            if let location = person.location?._content, !location.isEmpty {
                Text("📍 " + (location))
                    .font(.footnote)
            }
            
            Text("📸 " + "\(person.photos.count._content)")
                .font(.footnote)
            
            Text("🔗 " + person.profileurl._content)
                .font(.footnote)
        }
    }
}
