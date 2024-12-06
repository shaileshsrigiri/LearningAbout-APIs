//
//  ImageLoader.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/4/24.
//

//https://www.youtube.com/watch?v=Nm9sXBSHZsI&ab_channel=iOSAcademy

import UIKit

class ImageLoader {
    static func loadImage(from url: URL, into imageView: UIImageView) {
        let cacheKey = NSString(string: url.absoluteString)

        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            imageView.image = cachedImage
            return
        }

        NetworkManager.shared.fetchData(from: url.absoluteString) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    ImageCache.shared.setObject(image, forKey: cacheKey)
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            case .failure(let error):
                print("Error loading image: \(error)")
                DispatchQueue.main.async {
                    imageView.image = UIImage(systemName: "photo")
                }
            }
        }
    }
}
