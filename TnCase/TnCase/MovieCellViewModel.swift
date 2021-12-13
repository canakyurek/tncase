//
//  MovieCellViewModel.swift
//  TnCase
//
//  Created by Can Akyürek on 9.12.2021.
//

import Foundation


class MovieCellViewModel {

    private let name: String
    private let voteAverage: Double
    
    init(movie: Movie) {
        self.name = movie.name!
        self.voteAverage = movie.voteAverage!
    }
    
    func getName() -> String {
        return name
    }
    
    func getVoteAverageString() -> String {
        return "\(voteAverage)"
    }
}

