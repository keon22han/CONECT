//
//  SortBasis.swift
//  MarketProject
//
//  Created by 한건희 on 9/2/24.
//

import Foundation

enum SortingCriteria {
    case latest
    case accuracy
    case oldest

    var description: String {
        switch self {
        case .latest:
            return "Latest First"
        case .accuracy:
            return "Accuracy First"
        case .oldest:
            return "Oldest First"
        }
    }
    
    // Optionally, you can add more properties or methods if needed
    var sortOrder: String {
        switch self {
        case .latest:
            return "Sort by the latest date or time"
        case .accuracy:
            return "Sort by the highest accuracy"
        case .oldest:
            return "Sort by the oldest date or time"
        }
    }
}
