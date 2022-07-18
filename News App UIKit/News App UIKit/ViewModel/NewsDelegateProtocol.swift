//
//  NewsDelegateProtocol.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/9/22.
//

import Foundation

protocol NewsDelegate: AnyObject {
    func updateData()
    func changedFilterText(text: String)
    func scrollToTop()
}
