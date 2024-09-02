//
//  RecipeView.swift
//  MarketProject
//
//  Created by 한건희 on 9/1/24.
//

import Foundation
import UIKit

class RecipeView : UIView {
    
    // UI Contents
    
    let outerView = UIView()
    let recipeImageView = UIImageView()
    let recipeTitleLabel = UILabel()
    let recipeDescriptionLabel = UILabel()
    
    init(recipeImageURL: String, recipeTitleString: String, recipeDescriptionString: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.backgroundColor = .white
        self.addSubview(self.outerView)
        
        self.outerView.layer.cornerRadius = 10
        self.outerView.layer.shadowColor = UIColor.black.cgColor
        self.outerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.outerView.layer.shadowRadius = 3
        self.outerView.layer.shadowOpacity = 0.3
        self.outerView.layer.masksToBounds = false
        self.outerView.isUserInteractionEnabled = true
        
        self.recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.recipeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.recipeImageView.contentMode = .scaleAspectFill
        self.recipeImageView.layer.cornerRadius = 10
        self.recipeImageView.layer.masksToBounds = true
        
        CrawlingHelper.instance.loadImage(from: recipeImageURL, completion: { image in
            
            guard let recipeImage = image as UIImage? else {
                return
            }
            
            DispatchQueue.main.async {
                self.recipeImageView.image = recipeImage
            }
        })
        self.outerView.addSubview(self.recipeImageView)
        
        
        self.recipeTitleLabel.text = recipeTitleString
        self.recipeTitleLabel.textAlignment = .left
        self.recipeTitleLabel.textColor = .black
        self.recipeTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        self.recipeTitleLabel.numberOfLines = -1
        self.recipeTitleLabel.isUserInteractionEnabled = true
        self.outerView.addSubview(self.recipeTitleLabel)
        
        self.recipeDescriptionLabel.text = recipeDescriptionString
        self.recipeDescriptionLabel.textAlignment = .left
        self.recipeDescriptionLabel.textColor = .lightGray
        self.recipeDescriptionLabel.font = UIFont(name: "Pretendard-Medium", size: 11)
        self.recipeDescriptionLabel.numberOfLines = -1
        self.recipeDescriptionLabel.isUserInteractionEnabled = true
        self.outerView.addSubview(self.recipeDescriptionLabel)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 100),
            self.heightAnchor.constraint(equalToConstant: 400),
            
            self.outerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.outerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.outerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.outerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.recipeImageView.topAnchor.constraint(equalTo: self.outerView.topAnchor, constant: 5),
            self.recipeImageView.centerXAnchor.constraint(equalTo: self.outerView.centerXAnchor),
            self.recipeImageView.widthAnchor.constraint(equalToConstant: 90),
            self.recipeImageView.heightAnchor.constraint(equalToConstant: 90),
            
            self.recipeTitleLabel.topAnchor.constraint(equalTo: self.recipeImageView.bottomAnchor, constant: 10),
            self.recipeTitleLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 5),
            self.recipeTitleLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -5),
            
            self.recipeDescriptionLabel.topAnchor.constraint(equalTo: self.recipeTitleLabel.bottomAnchor, constant: 10),
            self.recipeDescriptionLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 5),
            self.recipeDescriptionLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
