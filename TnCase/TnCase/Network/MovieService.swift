//
//  Router.swift
//  Movie Reminder
//
//  Created by Can Akyurek on 21.05.2020.
//  Copyright © 2020 Can Akyurek. All rights reserved.
//

import Foundation

enum MovieService {
    case popular
    case image(String)
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
        case .popular, .image:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .popular:
            return "api.themoviedb.org"
        case .image:
            return "image.tmdb.org"
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/3/tv/popular"
        case .image(let imageId):
            return "/t/p/w500/\(imageId)"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .popular:
            return [
                "api_key" : apiKey,
                "language" : "en_US",
            ]
        case .image:
            return [:]
        }
    }
    
    var method: ServiceMethod {
        switch self {
        case .popular, .image:
            return .get
        }
    }
}
