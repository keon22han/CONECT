//
//  CreateRefrigeratorFoodSample.swift
//  MarketProject
//
//  Created by 한건희 on 8/31/24.
//

import Foundation
import UIKit

class CreateRefrigeratorFoodSample {
    
    public static let instance = CreateRefrigeratorFoodSample()
    
    private init() {
        
    }
    
    // 대파 마늘 당근 사과
    public func createSampleData() {
        let DBManagerInstance = DBManager.instance
        
        let appleImage = UIImage(named: "사과")
        DBManagerInstance.uploadImageToDB(image: appleImage!, completion: { imageDBUrl in
            if imageDBUrl == nil {
                print("upload image to database failed")
                return
            }
            
            let apple = Food(foodImageDBUrl: imageDBUrl!, foodName: "사과", calories: 10, carbohydrates: 9, sugars: 8, protein: 7, fat: 6, saturatedFat: 5, transFat: 4, cholesterol: 3, sodium: 2)
            
            DBManagerInstance.createFoodInfo(food: apple)
        })
        
        let daepaImage = UIImage(named: "대파")
        DBManagerInstance.uploadImageToDB(image: daepaImage!, completion: { imageDBUrl in
            if imageDBUrl == nil {
                print("upload image to database failed")
                return
            }
            
            let daepa = Food(foodImageDBUrl: imageDBUrl!, foodName: "대파", calories: 10, carbohydrates: 9, sugars: 8, protein: 7, fat: 6, saturatedFat: 5, transFat: 4, cholesterol: 3, sodium: 2)
            
            DBManagerInstance.createFoodInfo(food: daepa)
        })
        
        let maneulImage = UIImage(named: "마늘")
        DBManagerInstance.uploadImageToDB(image: maneulImage!, completion: { imageDBUrl in
            if imageDBUrl == nil {
                print("upload image to database failed")
                return
            }
            
            let maneul = Food(foodImageDBUrl: imageDBUrl!, foodName: "마늘", calories: 10, carbohydrates: 9, sugars: 8, protein: 7, fat: 6, saturatedFat: 5, transFat: 4, cholesterol: 3, sodium: 2)
            
            DBManagerInstance.createFoodInfo(food: maneul)
        })
        
        let carrotImage = UIImage(named: "당근")
        DBManagerInstance.uploadImageToDB(image: carrotImage!, completion: { imageDBUrl in
            if imageDBUrl == nil {
                print("upload image to database failed")
                return
            }
            
            let carrot = Food(foodImageDBUrl: imageDBUrl!, foodName: "당근", calories: 10, carbohydrates: 9, sugars: 8, protein: 7, fat: 6, saturatedFat: 5, transFat: 4, cholesterol: 3, sodium: 2)
            
            DBManagerInstance.createFoodInfo(food: carrot)
        })
        
        DBManagerInstance.createRefrigerator(refrigeratorName: "냉장고1")
        DBManagerInstance.createRefrigerator(refrigeratorName: "냉장고2")
        DBManagerInstance.createRefrigerator(refrigeratorName: "냉장고3")
        
        
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고1", foodName: "대파", foodCount: 100)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고1", foodName: "마늘", foodCount: 200)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고1", foodName: "당근", foodCount: 300)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고1", foodName: "사과", foodCount: 400)
        
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고2", foodName: "대파", foodCount: 1000)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고2", foodName: "마늘", foodCount: 2000)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고2", foodName: "당근", foodCount: 3000)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고2", foodName: "사과", foodCount: 4000)
        
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고3", foodName: "대파", foodCount: 10000)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고3", foodName: "마늘", foodCount: 20000)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고3", foodName: "당근", foodCount: 30000)
        DBManagerInstance.setRefrigeratorFood(refrigeratorName: "냉장고3", foodName: "사과", foodCount: 40000)
        
        
    }
}
