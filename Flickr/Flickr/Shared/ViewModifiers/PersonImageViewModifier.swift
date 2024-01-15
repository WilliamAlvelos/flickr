//
//  PersonImageViewModifier.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import SwiftUI

struct PersonImageViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.secondaryPink.gradient, 
                                     lineWidth: 2))
            .shadow(radius: 3)
            .padding(8)
    }
}

extension View {
    func personImageViewModifier() -> some View {
        self.modifier(PersonImageViewModifier())
    }
}
