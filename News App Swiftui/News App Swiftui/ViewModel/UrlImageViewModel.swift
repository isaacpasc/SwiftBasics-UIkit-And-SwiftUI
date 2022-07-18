//
//  UrlImageViewModel.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/10/22.
//

import SwiftUI

class UrlImageModel: ObservableObject {

    @Published var image: UIImage?
    var urlString: String?
    var imageCache = ImageCache.getImageCache()

    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }

    func loadImage() {
        if loadImageFromCache() { return }
        loadImageFromUrl()
    }

    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }

        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }

        image = cacheImage
        return true
    }

    func loadImageFromUrl() {
        guard let url = URL(string: urlString ?? "") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url,
                                              completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }


    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {

        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }

        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else { return }
            guard let urlString = self.urlString else { return }

            self.imageCache.set(forKey: urlString, image: loadedImage)
            self.image = loadedImage
        }
    }
}
