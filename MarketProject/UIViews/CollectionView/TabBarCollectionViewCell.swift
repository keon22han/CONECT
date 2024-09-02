//
//  TabBarCollectionViewCell.swift
//  MarketProject
//
//  Created by 한건희 on 8/21/24.
//

import Foundation
import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabBarCell"
    var titleLabel: UILabel!
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                titleLabel.textColor = .black
            } else {
                titleLabel.textColor = .lightGray
            }
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
}
