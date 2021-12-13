//
//  BaseMovie.swift
//  TnCase
//
//  Created by Can Akyürek on 8.12.2021.
//

import Foundation

struct BaseMovie: Codable {
    let page: Int?
    let results: [Movie]?
}
