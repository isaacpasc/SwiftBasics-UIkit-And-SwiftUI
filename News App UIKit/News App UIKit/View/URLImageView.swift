//
//  URLImageView.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class URLImageView: UIImageView {
    
    private var task: URLSessionDataTask!
    private var fallbackImage: UIImage?

    private let loadingView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = Theme.accentColor
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    func loadImage(from url: URL?, fallbackImage: UIImage) {
        
        self.fallbackImage = fallbackImage
        self.image = nil
        addLoadingView()
        if let task = task { task.cancel() }
        guard let url = url else {
            addErrorImage()
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = cachedImage
            removeLoadingView()
            return
        }
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.addErrorImage()
                }
                return
            }
            imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
                self.removeLoadingView()
            }
        }
        task.resume()
    }
    
    private func addLoadingView() {
        addSubview(loadingView)
        loadingView.startAnimating()
        loadingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
    
    private func addErrorImage() {
        if let fallbackImage = fallbackImage {
            removeLoadingView()
            image = fallbackImage
        }
    }
}
