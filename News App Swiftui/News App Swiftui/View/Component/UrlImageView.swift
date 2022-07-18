//
//  UrlImageView.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/10/22.
//

import SwiftUI

struct UrlImageView: View {

    @ObservedObject var urlImageViewModel: UrlImageModel

    init(urlString: String?) {
        urlImageViewModel = UrlImageModel(urlString: urlString)
    }

    var body: some View {
        if let image = urlImageViewModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
        } else {
            ProgressView("Loading Image")
                .progressViewStyle(.circular)
                .tint(Theme.accentColor)
        }
    }
}
