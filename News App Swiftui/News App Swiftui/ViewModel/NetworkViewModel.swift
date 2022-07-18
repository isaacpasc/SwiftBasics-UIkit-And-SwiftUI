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
    
    func fetchNews(from url: URL?) async throws -> News {
        guard let url = url else { throw NetworkError.invalidURL }
        return try await fetch(url: url)
    }
}
