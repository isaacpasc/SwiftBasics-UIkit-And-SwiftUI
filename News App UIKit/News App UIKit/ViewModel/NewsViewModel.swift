//
//  NewsViewModel.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/9/22.
//

import Foundation


final class NewsViewModel {

    var articles: [Article] = []
    var searchText = ""
    weak var newsDelegate: NewsDelegate?
    private var isFetching = false
    private var sortBy: Sort = Sort.relevancy
    private var page: Int = 1
    private var pageSize: Int = 10
    private var totalResults: Int = 0
    private let networkViewModel = NetworkViewModel()

    init() {
        fetchData(pagination: false)
    }
    // TODO: create lazy var for empty string test

    func fetchData(pagination: Bool) {
        if isFetching { return }
        Task {
            isFetching = true
            await setPage(pagination: pagination)
            do {
                guard !searchText.isEmptyAfterRemovingWhitespaces() else { throw NetworkError.invalidURL }
                let url = networkViewModel.generateNewsRequest(searchText: searchText,
                                                               sortBy: sortBy,
                                                               page: page,
                                                               pageSize: pageSize)
                let news = try await networkViewModel.fetchNews(from: url)
                if !pagination {
                    articles = news.articles ?? []
                    totalResults = news.totalResults ?? 0
                } else {
                    articles += news.articles ?? []
                }
                newsDelegate?.updateData()

                if let msg = news.message {
                    print("Message: \(msg)")
                }
                print("Total results: \(news.totalResults ?? -1) <- (if this is -1, total results came back nil)")
                print("Found: \(articles.count)\nSearching: \(searchText)\nSorting By: \(sortBy.rawValue)\nOn Page #: \(page)\nWith page Size of \(pageSize)")
                print("+++++++++++++++++++++++++++++++++++++++++++++")
            } catch {
                print("Error fetching news: -----\n\(error)")
            }
            isFetching = false
        }
    }

    func changeFilter() {
        if isFetching { return }
        if sortBy == Sort.relevancy {
            sortBy = Sort.popularity
            newsDelegate?.changedFilterText(text: "Most Popular")
        } else if sortBy == Sort.popularity {
            sortBy = Sort.publishedAt
            newsDelegate?.changedFilterText(text: "Most Recent")
        } else {
            sortBy = Sort.relevancy
            newsDelegate?.changedFilterText(text: "Most Relevant")
        }
        newsDelegate?.scrollToTop()
        fetchData(pagination: false)
    }

    private func setPage(pagination: Bool) async {
        if !pagination {
            page = 1
        } else {
            page += 1
        }
    }
}
