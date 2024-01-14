//
//  FlickrErrorView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct FlickrErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 100))
                .foregroundColor(Color.gray)
            
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(Color.gray)
                .padding()
            
            Button("ErrorView.Button.TryAgain".local,
                   action: retryAction)
                .buttonStyle(FlickrButtonStyle())
        }
        .padding()
    }
}

#Preview {
    FlickrErrorView(errorMessage: "Error message") {
        
    }
}
