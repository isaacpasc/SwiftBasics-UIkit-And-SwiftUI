//
//  SearchBarView.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI


struct SearchBar: View {

    @Binding var searchText: String
    @Binding var didSubmit: Bool
    @State private var canCancel: Bool = false

    var body: some View {
        ZStack {
            searchBarBackground
            searchBarContents
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding(.horizontal)
        .onChange(of: searchText) { newValue in
            if !newValue.isEmpty {
                withAnimation(.easeIn(duration: 0.1)) {
                    canCancel = true
                }
            } else {
                withAnimation(.easeIn(duration: 0.1)) {
                    canCancel = false
                }
            }
        }
    }

    private var searchBarBackground: some View {
        Rectangle()
            .foregroundColor(Color(UIColor.secondarySystemBackground))
    }

    private var searchBarContents: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            searchTextField
            if (canCancel) {
                Spacer()
                cancelButton
            }
        }
        .foregroundColor(.gray)
        .padding(.leading, 13)
    }

    private var cancelButton: some View {
        Image(systemName: "xmark")
            .padding(5)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            .onTapGesture {
                searchText = ""
            }
            .padding(.trailing, 13)
    }

    private var searchTextField: some View {
        TextField("Search", text: $searchText)
            .submitLabel(.search)
            .onSubmit {
                if !searchText.isEmptyAfterRemovingWhitespaces() {
                    didSubmit = true
                }
            }
    }
}
