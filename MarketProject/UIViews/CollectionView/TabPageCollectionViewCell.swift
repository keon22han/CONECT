//
//  TabPageCollectionViewCell.swift
//  MarketProject
//
//  Created by 한건희 on 8/21/24.
//

import Foundation
import UIKit

class TabPageCollectionViewCell: U {
    static let reuseIdentifier = "TabPageCell"
    lazy var backColor: [UIColor] = [.lightGray, .purple, .orange, .cyan, .magenta]
    
    func setColor(index: Int) {
        self.backgroundColor = backColor[index]
    }
}
