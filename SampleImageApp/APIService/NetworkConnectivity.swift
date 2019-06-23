//
//  NetworkConnectivity.swift
//  SampleImageApp
//
//  Created by Neha Pandey on 22/06/19.
//  Copyright © 2019 Neha Pandey. All rights reserved.
//

import Foundation
class NetworkConnectivity {
    // MARK: - Singleton
    public static let shared = NetworkConnectivity()
    private init() {}
    private let urlSession = URLSession.shared
    // MARK: - URL
    private let baseURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
    // MARK: - Enum for Errors
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    // MARK: - API Request Call
    func requestFetchResources(completion: @escaping (Result<AnyObject, APIServiceError>) -> Void) {
        
        guard var _ = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            // MARK: - Callback for Failure
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: baseURL) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    // MARK: - Callback for Failure
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    // MARK: - Parsing Response Data
                    if let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) {
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            utf8Data, options: [])
                        // MARK: - Callback for Success
                        completion(.success(jsonResponse as AnyObject))
                    }
                } catch {
                    // MARK: - Callback for Failure
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                print(error)
                // MARK: - Callback for Failure
                completion(.failure(.apiError))
            }
            }.resume()
    }
}
