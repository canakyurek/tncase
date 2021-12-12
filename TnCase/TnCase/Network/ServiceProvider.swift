//
//  ServiceProvider.swift
//  Movie Reminder
//
//  Created by Can Akyurek on 2.06.2020.
//  Copyright © 2020 Can Akyurek. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
    case empty
}

class ServiceProvider<T: Service> {
    var urlSession = URLSession.shared

    init() { }

    func load(service: T, completion: @escaping (NetworkResult<Data>) -> Void) {
        call(service.urlRequest, completion: completion)
    }

    func load<U>(service: T, decodeType: U.Type, completion: @escaping (NetworkResult<U>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
}

extension ServiceProvider {
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (NetworkResult<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            } else {
                deliverQueue.async {
                    completion(.empty)
                }
            }
            }.resume()
    }
}
