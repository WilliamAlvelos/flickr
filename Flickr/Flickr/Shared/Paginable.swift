//
//  Paginable.swift
//  Flickr
//
//  Created by William de Alvelos on 15/01/2024.
//

import SwiftUI

protocol Paginable {
    var status: Status { get }
    func loadMoreIfNeeded()
}

struct LastRowView: View {
    var viewModel: any Paginable

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
        .frame(height: 50)
        .onAppear {
            if viewModel.status == .loaded {
                viewModel.loadMoreIfNeeded()
            }
        }
    }
}
