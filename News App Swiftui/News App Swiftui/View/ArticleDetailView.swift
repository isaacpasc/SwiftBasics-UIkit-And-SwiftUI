//
//  ArticleDetailView.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

struct ArticleDetailView: View {

    @State private var presentSafariView = false
    @State private var presentShareSheet = false
    let article: Article
    var body: some View {
        articleScrollView
    }

    private var articleScrollView: some View {
        ScrollView(showsIndicators: false) {
            articleScrollViewContent
            .fullScreenCover(isPresented: $presentSafariView) {
                SFSafariViewWrapper(url: URL(string: article.url ?? "") ?? URL(string: "https://google.com")!)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $presentShareSheet) {
                ActivityView(url: URL(string: article.url ?? "") ?? URL(string: "https://google.com")!)
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if let _ = URL(string: article.url ?? "") {
                        shareButton
                    }
                }
            }
        }
    }

    private var articleScrollViewContent: some View {
        VStack(alignment: .leading, spacing: LayoutGuide.padding) {
            articleImage
            articleTitle
            authorAndPublishedDateHStack
            articleContent
            safariButton
        }
        .padding(LayoutGuide.padding)
    }

    private var articleImage: some View  {
        UrlImageView(urlString: article.urlToImage)
            .frame(width: UIScreen.main.bounds.width - (LayoutGuide.padding * 2), height: 200)
    }

    private var articleTitle: some View {
        Text(article.title ?? "")
            .font(.headline)
            .foregroundColor(Color.primary)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }

    private var authorAndPublishedDateHStack: some View {
        HStack {
            authorName
            Spacer()
            publishedDate
        }
    }

    private var authorName: some View {
        Text(article.author ?? "")
            .font(.subheadline)
            .foregroundColor(Color.secondary)
            .lineLimit(1)
    }

    private var publishedDate: some View {
        Text(article.publishedAt?.utcToLocal() ?? "")
            .font(.subheadline)
            .foregroundColor(Color.secondary)
            .lineLimit(1)
    }

    private var articleContent: some View {
        Text(String(repeating: article.content ?? "", count: 10))
            .font(.footnote)
            .foregroundColor(Color.secondary)
            .multilineTextAlignment(.leading)
    }

    private var shareButton: some View {
        Button {
            presentShareSheet.toggle()
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
    }

    @ViewBuilder
    private var safariButton: some View {
        if let _ = URL(string: article.url ?? "") {
            HStack {
                Spacer()
                CapsuleButton(text: "Open in Safari", iconSystemName: "safari") {
                    presentSafariView.toggle()
                }
                Spacer()
            }
        }
    }

}
