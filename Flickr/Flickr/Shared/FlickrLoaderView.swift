//
//  FlickrLoaderView.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct FlickrLoaderView: View {
    @State private var blueScale: CGFloat = 1.0
    @State private var pinkScale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Spacer()

            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.primaryBlue)
                    .scaleEffect(blueScale)
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.secondaryPink)
                    .scaleEffect(pinkScale)
            }
            Spacer()
        }.onAppear {
            pulseCircles()
        }
    }
    
    private func pulseCircles() {
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            pinkScale = 0.5
            blueScale = 1.5
        }
        
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true).delay(1.0)) {
            pinkScale = 1.5
            blueScale = 0.5
        }
    }
}
