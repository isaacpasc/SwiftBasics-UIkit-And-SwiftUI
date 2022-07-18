//
//  TextStyles.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

extension Text {

    func mainTitleStyle() -> some View {
        self.foregroundColor(Theme.accentColor)
            .font(.system(size: 100))
    }
}
