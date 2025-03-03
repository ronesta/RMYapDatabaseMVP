//
//  ImageLoader.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 03.03.2025.
//

import Foundation
import UIKit.UIImage

final class ImageLoader: ImageLoaderProtocol {
    private var counter = 1

    private let storageManager: StorageManagerProtocol

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {

        if let imageData = storageManager.loadImage(characterId: urlString),
           let image = UIImage(data: imageData) {
            completion(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let data,
               let image = UIImage(data: data) {
                self.storageManager.saveImage(data, key: urlString)
                DispatchQueue.main.async {
                    completion(image)
                    print("Load image \(self.counter)")
                    self.counter += 1
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
