//
//  RequestError.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case serverError
    case networkError
}
