//
//  EmptyStringCheck.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/10/22.
//

import Foundation

extension String {

    func isEmptyAfterRemovingWhitespaces() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
