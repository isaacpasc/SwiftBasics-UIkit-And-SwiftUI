//
//  ResultsView.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

struct ResultsView: View {

    @StateObject private var newsViewModel: NewsViewModel
    @State private var presentDatePicker: Bool = false
    @State private var didChangeDate: Bool = false
    @State private var searchText: String

    init(searchText: String) {
        self._newsViewModel = StateObject(wrappedValue: NewsViewModel(searchText: searchText))
        self.searchText = searchText
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { scrollIndex in
                LazyVStack {
                    ForEach(newsViewModel.articles.indices, id: \.self) { i in
                        NavigationLink {
                            ArticleDetailView(article: newsViewModel.articles[i])
                        } label: {
                            ArticleRowView(article: newsViewModel.articles[i])
                                .id(i)
                                .onAppear {
                                    if i == newsViewModel.articles.count - 1 {
                                        newsViewModel.fetchData(isPagination: true)
                                    }
                                }
                        }
                    }
                    .onChange(of: newsViewModel.scrollToTop) { newValue in
                        if newValue {
                            scrollIndex.scrollTo(0, anchor: .top)
                            newsViewModel.scrollToTop = false
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea([.horizontal, .bottom])
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                sortingMenu
            }
            ToolbarItemGroup(placement: .principal) {
                navigationBarTitleAndDateRange
            }
        }
        .sheet(isPresented: $presentDatePicker) {
            fetchMoreArticlesWithNewDates()
        } content: {
            DateSelector(startDate: $newsViewModel.startDate,
                         endDate: $newsViewModel.endDate,
                         didChangeDate: $didChangeDate)
        }
    }

    private var sortingMenu: some View {
        Menu {
            Button("Most Relevant") {
                newsViewModel.sortBy = Sort.relevancy
                newsViewModel.fetchData(isPagination: false)
            }
            Button("Most Recent") {
                newsViewModel.sortBy = Sort.publishedAt
                newsViewModel.fetchData(isPagination: false)
            }
            Button("Most Popular") {
                newsViewModel.sortBy = Sort.popularity
                newsViewModel.fetchData(isPagination: false)
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
        }
    }

    private var navigationBarTitleAndDateRange: some View {
        VStack(spacing: 0) {
            Text("\(searchText)")
            Button {
                presentDatePicker.toggle()
            } label: {
                HStack {
                    Text("\(newsViewModel.startDate.toString()) - \(newsViewModel.endDate.toString())")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.down")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private func fetchMoreArticlesWithNewDates() {
        if didChangeDate {
            newsViewModel.fetchData(isPagination: false)
            didChangeDate = false
        } else {
            let oneMonthPrior = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
            newsViewModel.startDate = newsViewModel.prevStartDate ?? oneMonthPrior
            newsViewModel.endDate = newsViewModel.prevEndDate ?? Date()
        }
    }
}
