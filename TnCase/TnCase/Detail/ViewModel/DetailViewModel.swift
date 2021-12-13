//
//  DetailViewModel.swift
//  TnCase
//
//  Created by Can Akyürek on 12.12.2021.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class DetailViewModel {
    
    private let title: String?
    private let description: String?
    let backdropImage: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    private let provider = ServiceProvider<MovieService>()
    let error: PublishSubject<MovieError> = PublishSubject()
    private let imageLink: String?
    
    init(movie: Movie) {
        self.title = movie.name
        self.description = movie.overview
        self.imageLink = movie.backdropPath
    }
    
    func getTitle() -> String {
        guard let title = title,
                title.isEmpty == false else {
            return "<No title provided>"
        }
        return title
    }
    
    func getDescription() -> String {
        guard let description = description,
                description.isEmpty == false else {
            return "<No description provided>"
        }
        return description
    }
    
    func getImage() {
        guard let imageLink = imageLink else {
            self.backdropImage.accept(UIImage(named: "image_placeholder"))
            return
        }

        provider.load(service: .image(imageLink)) { result in
            switch result {
            case .success(let data):
                self.backdropImage.accept(UIImage(data: data))
            case .failure(let error):
                self.error.onNext(.serverError(error.localizedDescription))
            case .empty:
                self.error.onNext(.emptyResponseError("Empty response"))
            }
        }
    }
}
