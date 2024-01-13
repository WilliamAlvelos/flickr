//
//  ViewFirstAppearModifier.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

public extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
}

struct ViewFirstAppearModifier: ViewModifier {
    @State private var isFirstAppear = true
    private let action: () -> Void

    init(perform action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            guard isFirstAppear else { return }
            isFirstAppear = false
            action()
        }
    }
}
