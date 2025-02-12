//
//  InAppImagesStorage.swift
//  Mindbox
//
//  Created by Максим Казаков on 06.09.2022.
//  Copyright © 2022 Mikhail Barilov. All rights reserved.
//

import Foundation
import UIKit

protocol InAppImagesStorageProtocol: AnyObject {
    func getImage(url: URL, completionQueue: DispatchQueue, completion: @escaping (Data?) -> Void)
}

/// This class manages images from in-app messages
final class InAppImagesStorage: InAppImagesStorageProtocol {

    func getImage(url: URL, completionQueue: DispatchQueue, completion: @escaping (Data?) -> Void) {
        downloadImage(url: url, completionQueue: completionQueue, completion: completion)
    }

    // MARK: - Private

    private func downloadImage(url: URL, completionQueue: DispatchQueue, completion: @escaping (Data?) -> Void) {
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionQueue.async {
                if let error = error {
                    completion(nil)
                } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completion(nil)
                } else if let data = data {
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }
        .resume()
    }
}
