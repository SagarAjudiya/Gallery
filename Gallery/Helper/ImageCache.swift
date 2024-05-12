//
//  ImageCache.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    private let cacheDirectory: URL

    private init() {
        cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func fetchImage(from url: URL, _ completion: @escaping (UIImage?) -> Void) {
        let fileName = url.lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(fileName)

        // Check if image is already cached
        if let cachedImage = UIImage(contentsOfFile: fileURL.path) {
            completion(cachedImage)
            return
        }
        
        if !Reachability.isConnectedToNetwork() {
            completion(UIImage(named: "imgPlaceHolder"))
            print(self, "No Internet")
            return
        }

        // If not cached, download and cache the image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            do {
                try data.write(to: fileURL)
            } catch {
                print("Error saving image: \(error)")
            }
            completion(image)
        }
        task.resume()
    }
    
}

extension UIImageView {
    
    func loadImage(_ imageStr: String?) {
        if let imageStr, let url = URL(string: imageStr) {
            ImageCache.shared.fetchImage(from: url) { image in
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
}
