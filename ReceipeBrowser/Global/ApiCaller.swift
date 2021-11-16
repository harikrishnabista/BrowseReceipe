//
//  ApiCaller.swift
//  ReceipeBrowser
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

enum APIResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case failure(Error)
    case unknown
}

protocol ApiCallerProcol {
    associatedtype ResponseType: Decodable
    var baseUrl: String { get set }
    var queryItems: [URLQueryItem] { get set }
    func callApi(endPoint: String, completion: @escaping (APIResult<ResponseType>) -> Void)
}

extension ApiCallerProcol {
    func callApi(endPoint: String,
                 completion: @escaping (APIResult<ResponseType>) -> Void) {
        guard let url = URL(string: self.baseUrl + endPoint) else {
            completion(APIResult.failure(.unknown))
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = self.queryItems
        
        guard let apiUrl = urlComponents?.url else {
            completion(APIResult.failure(.unknown))
            return
        }
        
        print("Loading Data from: \(apiUrl.absoluteString)")
        let urlRequest = URLRequest(url: apiUrl)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            do {
                if let data = data, error == nil {
                    let returnObj = try JSONDecoder().decode(ResponseType.self, from: data)
                    completion(APIResult.success(returnObj))
                } else if let error = error {
                    completion(APIResult.failure(.failure(error)))
                }
            } catch let error {
                print(error.localizedDescription)
                completion(APIResult.failure(.failure(error)))
            }
        }
        task.resume()
    }
}

class DefaultApiCaller<T: Decodable> : ApiCallerProcol {
    var queryItems: [URLQueryItem] = []
    typealias ResponseType = T
    var baseUrl = "https://www.themealdb.com/api/"
    var appid = ""
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
}
