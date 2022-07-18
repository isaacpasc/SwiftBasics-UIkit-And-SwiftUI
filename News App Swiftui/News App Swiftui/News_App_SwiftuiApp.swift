//
//  News_App_SwiftuiApp.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

@main
struct News_App_SwiftuiApp: App {

    init() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }

    var body: some Scene {
        WindowGroup {
            SearchView()
                .accentColor(Theme.accentColor)
        }
    }
}
