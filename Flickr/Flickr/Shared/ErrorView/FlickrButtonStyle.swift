//
//  FlickrButtonStyle.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct FlickrButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .bold()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.primaryBlue)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct ContentView: View {
    var body: some View {
        Button("Tap me") { }
            .buttonStyle(FlickrButtonStyle())
    }
}

#Preview {
    Group {
        ContentView()
            .environment(\.colorScheme, .light)
        
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
