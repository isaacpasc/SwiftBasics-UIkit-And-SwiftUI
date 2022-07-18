//
//  NetworkViewModel.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import Foundation

final class NetworkViewModel {
    
    private func fetch<T: Decodable>(url: URL) async throws -> T {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
    }
    
    func generateNewsRequest(searchText query: String,
                             sortBy: Sort,
                             page: Int,
                             pageSize: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "pageSize", value: "\(pageSize > 100 ? 100 : pageSize)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sortBy", value: sortBy.rawValue),
            URLQueryItem(name: "apiKey", value: Key.apikey)
        ]
        print(components.url)
        return components.url
    }
    
    func fetchNews(from url: URL?) async throws -> News {
        guard let url = url else { throw NetworkError.invalidURL }
        return try await fetch(url: url)
    }
}
