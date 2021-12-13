//
//  ViewController.swift
//  TnCase
//
//  Created by Can Akyürek on 7.12.2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel = {
        return MovieViewModel()
    }
    var movies = PublishSubject<[Movie]>()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupBindings()
        viewModel.fetchMovies()
    }
    
    // MARK: - Custom methods
        collectionView.dataSource = self
    func setupBindings() {
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe (onNext: { error in
                switch error {
                case .serverError(let message):
                    print(message)
                case .emptyResponseError(let message):
                    print(message)
                }
            })
            .disposed(by: disposeBag)


        viewModel
            .movies
            .observe(on: MainScheduler.instance)
            .bind(to: movies)
            .disposed(by: disposeBag)
        
        movies
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) { (row, movie, cell) in
            let cellViewModel = MovieCellViewModel(movie: movie)
            cell.configure(cellViewModel)
        }
        .disposed(by: disposeBag)
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
