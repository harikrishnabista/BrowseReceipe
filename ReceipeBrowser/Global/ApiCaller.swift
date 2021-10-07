//
//  ApiCaller.swift
//  ReceipeBrowser
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case ApiError(Error)
    case Unknown
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

class ApiCaller {
    func callApi<T: Decodable>(responseType: T.Type, url:URL, completion: @escaping (APIResult<T>) -> Void) {
        
        print("Loading Data from: \(url.absoluteString)")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, respose, error) in

            do {
                if let data = data, error == nil {
                    let returnObj = try JSONDecoder().decode(T.self, from: data)
                    completion(APIResult.success(returnObj))
                } else if let error = error {
                    completion(APIResult.failure(error))
                }
            } catch let error {
                completion(APIResult.failure(error))
            }
        }
        task.resume()
    }
}

class ImageDownloadHelper {
    public static let shared = ImageDownloadHelper()
    
    private var cache:[URL: UIImage] = [:]
    
    func downloadImage(url: URL, completion: @escaping (UIImage?)-> Void) {
        if let image = self.cache[url] {
            completion(image)
        } else {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, respose, error) in
                do {
                    if let data = data, error == nil {
                        let image = UIImage(data: data)
                        
                        if let image = image {
                            self.cache[url] = image
                        }
                        
                        completion(image)
                    } else if let error = error {
                        completion(nil)
                    }
                } catch _ {
                    if let error = error {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    /*
    func downloadImage(url: URL, completion: @escaping (UIImage?)-> Void) {
        if let image = self.cache[url] {
            completion(image)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    
                    if let image = image {
                        self.cache[url] = image
                    }
                    
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    } */
}
