//
//  Reusable.swift
//  TnCase
//
//  Created by Can Akyürek on 12.12.2021.
//

import Foundation
import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
