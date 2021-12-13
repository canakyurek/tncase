//
//  Movie.swift
//  TnCase
//
//  Created by Can Akyürek on 8.12.2021.
//

import Foundation

struct Movie: Codable {
    let name: String?
    let backdropPath: String?
    let voteAverage: Double?
    let overview: String?
}
