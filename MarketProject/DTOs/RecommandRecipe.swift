//
//  RecommandRecipe.swift
//  MarketProject
//
//  Created by 한건희 on 9/1/24.
//

import Foundation
import UIKit

class RecommandRecipe {
    
    var recipeImageURL: String?
    var recipeName: String?
    var recipeDescription: String?
    var recipeLink: String?
    
    init(recipeImageURL: String? = nil, recipeName: String? = nil, recipeDescription: String? = nil, recipeLink: String? = nil) {
        self.recipeImageURL = recipeImageURL
        self.recipeName = recipeName
        self.recipeDescription = recipeDescription
        self.recipeLink = recipeLink
    }
}
