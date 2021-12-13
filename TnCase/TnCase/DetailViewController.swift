//
//  DetailViewController.swift
//  TnCase
//
//  Created by Can Akyürek on 12.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateLabels()
        setupBindings()
        viewModel.getImage()
    }
    
    private func populateLabels() {
        title = viewModel.getTitle()
        titleLabel.text = viewModel.getTitle()
        infoLabel.text = viewModel.getDescription()
    }
    
    private func setupBindings() {
        viewModel
            .backdropImage
            .asObservable().bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }

}
