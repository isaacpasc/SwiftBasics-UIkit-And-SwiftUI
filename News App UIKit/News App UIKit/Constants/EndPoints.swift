//
//  EndPoints.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import Foundation

enum Sort: String {
    case relevancy = "relevancy"
    case popularity = "popularity"
    case publishedAt = "publishedAt"
}

enum Key {
    static let apikey = "e9ae51896a664d9fa4edeff8de84243d"
}

struct Endpoint {
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    static func generateNewsRequest(searchText query: String,
                                    sortBy: Sort,
                                    page: Int,
                                    pageSize: Int,
                                    startDate: Date,
                                    endDate: Date) -> URL? {
        return Endpoint(scheme: "https",
                        host: "newsapi.org",
                        path: "/v2/everything",
                        queryItems: [
                            URLQueryItem(name: "q", value: query),
                            URLQueryItem(name: "pageSize", value: "\(pageSize > 100 ? 100 : pageSize)"),
                            URLQueryItem(name: "page", value: "\(page)"),
                            URLQueryItem(name: "from", value: startDate.ISO8601Format()),
                            URLQueryItem(name: "to", value: endDate.ISO8601Format()),
                            URLQueryItem(name: "sortBy", value: sortBy.rawValue),
                            URLQueryItem(name: "apiKey", value: Key.apikey)
                        ]).url
    }
}
