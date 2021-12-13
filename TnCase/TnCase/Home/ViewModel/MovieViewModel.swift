//
//  MovieViewModel.swift
//  TnCase
//
//  Created by Can Akyürek on 7.12.2021.
//

import Foundation
import RxSwift

class MovieViewModel {
    
    let movies: PublishSubject<[Movie]> = PublishSubject()
    let error: PublishSubject<MovieError> = PublishSubject()
    private let provider = ServiceProvider<MovieService>()
    
    private let disposable = DisposeBag()
    
    func fetchMovies() {
        provider.load(service: .popular, decodeType: BaseMovie.self) { result in
            switch result {
            case .success(let base):
                if let movies = base.results {
                    self.movies.onNext(movies)
                }
            case .failure(let error):
                self.error.onNext(.serverError(error.localizedDescription))
            case .empty:
                self.error.onNext(.emptyResponseError("Empty response"))
            }
        }
    }
}
