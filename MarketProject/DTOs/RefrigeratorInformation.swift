//
//  RefrigeratorInformation.swift
//  MarketProject
//
//  Created by 한건희 on 8/30/24.
//

import Foundation

class RefrigeratorInformation {
    
    /*
Foods
  FoodId (Foods 의 각 음식 정보(열량, 지방, 탄수화물 등) 의 Id)
     
     |--- foodName - Float
     |
     |--- calories - Float
     |.
     |.
     |--- fat - String
     |
     |--- CountsStatus
     |       |
     |       |--- RefrigeratorId: String
     |                  |
     |                  |--- count: Int
     |
     |
     |
     |
     |
     |
     |
     |
     */
    var refrigeratorName: String? // DB
    
    // TODO: 현재 사용 가능한 상황인지... 등등 여부 냉장고 정보에 추가 필요
    
    var foodsCountInfo = [String: Int]()
    
    init() {
        
    }
    
    public func setRefrigeratorName(refrigeratorName: String) {
        self.refrigeratorName = refrigeratorName
    }
    
    public func setField(fieldName: String, fieldValue: Any) {
        switch fieldName {
        case "refrigeratorName" :
            self.refrigeratorName = (fieldValue as! String)
        case "FoodsCountInfo" :
            setFoodsCount(foodsCountInfo: fieldValue as! [String: [String: Int]])
        default:
            return
        }
    }
    
    public func setFoodsCount(foodsCountInfo: [String: [String: Int]]) {
        for (key, value) in foodsCountInfo {
            self.foodsCountInfo[key] = value["Counts"]
        }
    }
    
    public func getFoodsInfo() -> [String: Int] {
        return self.foodsCountInfo
    }
    
}
