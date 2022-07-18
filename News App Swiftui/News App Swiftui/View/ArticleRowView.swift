//
//  ArticleRowView.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

struct ArticleRowView: View {

    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: LayoutGuide.padding) {
            image
            title
            authorAndPublishDate
            description
        }
        .padding(LayoutGuide.padding)
    }

    private var image: some View {
        UrlImageView(urlString: article.urlToImage)
            .frame(width: UIScreen.main.bounds.width - (LayoutGuide.padding * 2), height: 200)
    }

    private var title: some View {
        Text(article.title ?? "")
            .font(.headline)
            .foregroundColor(Color.primary)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }

    private var authorAndPublishDate: some View {
        HStack {
            Text(article.author ?? "")
                .font(.subheadline)
                .foregroundColor(Color.secondary)
                .lineLimit(1)
            Spacer()
            Text(article.publishedAt?.utcToLocal() ?? "")
                .font(.subheadline)
                .foregroundColor(Color.secondary)
                .lineLimit(1)
        }
    }

    private var description: some View {
        Text(article.description ?? "")
            .font(.footnote)
            .foregroundColor(Color.secondary)
            .multilineTextAlignment(.leading)
    }
}
