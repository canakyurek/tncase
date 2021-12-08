//
//  Router.swift
//  Movie Reminder
//
//  Created by Can Akyurek on 21.05.2020.
//  Copyright © 2020 Can Akyurek. All rights reserved.
//

import Foundation

enum MovieService {
    case popular()
}

extension MovieService: Service {
    
    private var apiKey: String {
        return "2a8a6defc6b9b2f45a4aa9922d333420"
    }
    
    var baseURL: String {
        return "\(scheme)://\(host)"
    }
    
    var scheme: String {
        switch self {
        case .popular()
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .popular()
            return "developers.themoviedb.org/3/tv/"
        }
    }
    
    var path: String {
        switch self {
        case .popular()
            return "get-popular-tv-shows"
    }
    
    var parameters: [String: Any]? {
        // For 3rd version
        
        switch self {
        case .popular()
            return [
                "api_key" : apiKey,
                "language" : "en_US",
            ]
    }
    
    var method: ServiceMethod {
        switch self {
        case .popular()
            return .get
        }
    }
}
