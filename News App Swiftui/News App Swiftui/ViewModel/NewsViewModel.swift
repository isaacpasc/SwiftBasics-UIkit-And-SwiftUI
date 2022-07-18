//
//  NewsViewModel.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

final class NewsViewModel: ObservableObject {

    private var isFetching = false
    private let networkViewModel = NetworkViewModel()
    private var page = 1
    private var pageSize = 10
    private var totalResults = 0
    private var searchText = ""
    var sortBy = Sort.relevancy
    var prevStartDate: Date?
    var prevEndDate: Date?
    @Published var scrollToTop = false
    @Published var articles: [Article] = []
    @Published var startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
    @Published var endDate = Date()

    init(searchText: String) {
        self.searchText = searchText
        fetchData(isPagination: false)
    }

    func fetchData(isPagination: Bool) {
        if isFetching { return }
        prevEndDate = endDate
        prevStartDate = startDate
        Task {
            isFetching = true
            await setPage(isPagination: isPagination)
            do {
                guard !searchText.isEmptyAfterRemovingWhitespaces() else { throw NetworkError.invalidURL }
                let url = Endpoint.generateNewsRequest(searchText: searchText,
                                                       sortBy: sortBy,
                                                       page: page,
                                                       pageSize: pageSize,
                                                       startDate: startDate,
                                                       endDate: endDate)
                let news = try await networkViewModel.fetchNews(from: url)
                if !isPagination {
                    DispatchQueue.main.async {
                        self.articles = news.articles ?? []
                    }
                    totalResults = news.totalResults ?? 0
                } else {
                    DispatchQueue.main.async {
                        self.articles += news.articles ?? []
                    }
                }
                if let msg = news.message {
                    print("MESSAGE: -- \(msg)")
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

    private func setPage(isPagination: Bool) async {
        if !isPagination {
            DispatchQueue.main.async {
                self.scrollToTop = true
            }
            page = 1
        } else {
            page += 1
        }
    }
}
