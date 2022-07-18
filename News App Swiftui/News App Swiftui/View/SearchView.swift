//
//  SearchView.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

struct SearchView: View {

    @State private var searchText: String = ""
    @State private var presentArticlesView: Bool = false

    var body: some View {

        NavigationView {

            VStack(spacing: 40) {
                Text("News").mainTitleStyle()
                SearchBar(searchText: $searchText, didSubmit: $presentArticlesView)
                searchButton
                NavigationLink(destination: ResultsView(searchText: searchText), isActive: $presentArticlesView) { EmptyView() }
            }
            .navigationViewStyle(.stack)
            .navigationTitle("")
            .navigationBarHidden(true)
            .gesture(DragGesture().onChanged { _ in
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
        }
    }

    private var searchButton: some View {
        Button {
            presentArticlesView.toggle()
        } label: {
            HStack {
                Text("Search")
                Image(systemName: "magnifyingglass")
            }
            .font(.system(size: 20))
            .foregroundColor(.white)
            .padding()
            .background(
                Capsule()
                    .fill(searchText.isEmptyAfterRemovingWhitespaces() ? .gray : Theme.accentColor)
            )
        }
        .disabled(searchText.isEmptyAfterRemovingWhitespaces())
    }
}
