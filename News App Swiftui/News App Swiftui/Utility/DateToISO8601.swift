//
//  DateToISO8601.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import Foundation

extension Date {

    func toISO8601() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withDay)
        return formatter.string(from: self)
    }
}
