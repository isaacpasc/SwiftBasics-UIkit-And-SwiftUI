//
//  ShareSheetViewController.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/10/22.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}
