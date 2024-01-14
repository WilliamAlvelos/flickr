//
//  SearchPersonView.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct SearchPersonView: View {
    let person: SearchPerson
    
    var body: some View {
        HStack(alignment: .center) {
            ImageView(imageURL: person.iconURL)
                .frame(width: 50, height: 50)
                .personImageViewModifier()
            
            VStack(alignment: .leading) {
                Text(person.username)
                    .font(.headline)
                if !person.realname.isEmpty {
                    Text(person.realname)
                        .font(.footnote)
                }
            }
            
            Spacer()
            
            if person.isPro.boolValue {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.secondaryPink)
            }
            
        }
    }
}
