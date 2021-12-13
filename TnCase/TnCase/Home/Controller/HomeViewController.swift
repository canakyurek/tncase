//
//  ViewController.swift
//  TnCase
//
//  Created by Can Akyürek on 7.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    // MARK: - Outlet connections
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    lazy var viewModel = {
        return MovieViewModel()
    }()
    
    var movies = PublishSubject<[Movie]>()
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular TV Shows"
        tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        setupBindings()
        viewModel.fetchMovies()
    }
    
    // MARK: - Custom methods
    
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
        
        tableView.rx.modelSelected(Movie.self).subscribe(onNext: { [unowned self] movie in
            let detailViewModel = DetailViewModel(movie: movie)
            performSegue(withIdentifier: "segue", sender: detailViewModel)
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let destination = segue.destination as? DetailViewController,
                let viewModel = sender as? DetailViewModel {
                destination.viewModel = viewModel
            }
        }
    }
}
