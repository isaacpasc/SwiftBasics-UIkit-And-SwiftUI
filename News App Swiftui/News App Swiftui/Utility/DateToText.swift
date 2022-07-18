//
//  DateToText.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import Foundation

extension Date {

    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
}
