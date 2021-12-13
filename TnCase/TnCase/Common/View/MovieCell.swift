//
//  MovieCell.swift
//  TnCase
//
//  Created by Can Akyürek on 9.12.2021.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(_ viewModel: MovieCellViewModel) {
        nameLabel.text = viewModel.getName()
        voteAverageLabel.text = viewModel.getVoteAverageString()
    }
}
