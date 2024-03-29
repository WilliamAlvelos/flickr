//
//  FLEmptyView.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import SwiftUI

enum FLEmptyViewType: String {
    case photos
    case tags
    case user
    case groups
    
    var systemName: String {
        switch self {
        case .photos: return "photo.on.rectangle"
        case .groups: return "person.3.fill"
        case .user: return "person.fill"
        case .tags: return "tag.slash"
        }
    }
    
    var message: String {
        return "EmptyView.Message".local(with: [rawValue])
    }
}

struct FLEmptyView: View {
    
    var type: FLEmptyViewType = .photos
    
    var body: some View {
        VStack() {
            Spacer()
            Image(systemName: type.systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.secondary)
            
            Text(type.message)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FLEmptyView()
}
