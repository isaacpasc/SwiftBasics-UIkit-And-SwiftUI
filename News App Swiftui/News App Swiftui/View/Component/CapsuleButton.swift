//
//  CapsuleButton.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

struct CapsuleButton: View {
    
    var text: String
    var iconSystemName: String
    var clicked: (() -> Void)

    var body: some View {
        Button(action: clicked) {
            HStack {
                Text(text)
                Image(systemName: iconSystemName)
            }
            .foregroundColor(.white)
            .padding()
            .background(
                Capsule()
                    .fill(Theme.accentColor)
            )
        }
    }
}
