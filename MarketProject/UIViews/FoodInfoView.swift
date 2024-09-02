//
//  FoodInfoView.swift
//  MarketProject
//
//  Created by 한건희 on 8/31/24.
//

import Foundation
import UIKit

class FoodInfoView: UIView {
    
    let foodInfo: Food
    let foodCount: Int
    
    
    // View Contents
    let foodImageView = UIImageView()
    
    let foodNameLabel = UILabel()
    
    let caloriesLabel = UILabel()
    let carbohydratesLabel = UILabel()
    let sugarsLabel = UILabel()
    let proteinLabel = UILabel()
    let fatLabel = UILabel()
    let saturatedFatLabel = UILabel()
    let transFatLabel = UILabel()
    let cholesterolLabel = UILabel()
    let sodiumLabel = UILabel()
    
    let foodCountLabel = UILabel()
    
    var viewTappedCommand : () -> Void
    
    // TODO: 영양성분 등 추가
    
    
    init(foodInfo: Food, foodCount: Int, viewTappedCommand: @escaping(() -> Void)) {
        self.foodInfo = foodInfo
        self.foodCount = foodCount
        self.viewTappedCommand = viewTappedCommand
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        self.layer.cornerRadius = 10
        
        // View Shadow 추가
        self.layer.shadowColor = UIColor.black.cgColor // 색깔
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 4, height: 4) // 위치조정
        self.layer.shadowRadius = 5 // 반경
        self.layer.shadowOpacity = 0.3 // alpha값
        
        self.backgroundColor = .white
        
        self.foodImageView.translatesAutoresizingMaskIntoConstraints = false
        self.foodImageView.contentMode = .scaleAspectFill
        self.foodImageView.layer.cornerRadius = 15
        self.foodImageView.layer.masksToBounds = true
        DBManager.instance.downloadImageFromDB(imageURL: self.foodInfo.foodImageDBUrl!, completion: { foodImage in
            if foodImage == nil {
                self.foodImageView.image = UIImage(named: "store-default")
            } else {
                self.foodImageView.image = foodImage
            }
        })
        
        self.addSubview(self.foodImageView)
        
        self.foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.foodNameLabel.text = "재료명 : " + foodInfo.foodName!
        self.foodNameLabel.textAlignment = .left
        self.foodNameLabel.textColor = .black
        self.foodNameLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.foodNameLabel.numberOfLines = -1
        self.addSubview(self.foodNameLabel)
        
        self.caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.caloriesLabel.text = "칼로리 : " + String(describing: foodInfo.calories!)
        self.caloriesLabel.textAlignment = .left
        self.caloriesLabel.textColor = .black
        self.caloriesLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.caloriesLabel.numberOfLines = -1
        self.addSubview(self.caloriesLabel)
        
        self.carbohydratesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.carbohydratesLabel.text = "탄수화물 : " + String(describing: foodInfo.carbohydrates!)
        self.carbohydratesLabel.textAlignment = .left
        self.carbohydratesLabel.textColor = .black
        self.carbohydratesLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.carbohydratesLabel.numberOfLines = -1
        self.addSubview(self.carbohydratesLabel)
        
        self.sugarsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sugarsLabel.text = "당류 : " + String(describing: foodInfo.sugars!)
        self.sugarsLabel.textAlignment = .left
        self.sugarsLabel.textColor = .black
        self.sugarsLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.sugarsLabel.numberOfLines = -1
        self.addSubview(self.sugarsLabel)
        
        self.proteinLabel.translatesAutoresizingMaskIntoConstraints = false
        self.proteinLabel.text = "단백질 : " + String(describing: foodInfo.protein!)
        self.proteinLabel.textAlignment = .left
        self.proteinLabel.textColor = .black
        self.proteinLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.proteinLabel.numberOfLines = -1
        self.addSubview(self.proteinLabel)
        
        self.fatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.fatLabel.text = "지방 : " + String(describing: foodInfo.fat!)
        self.fatLabel.textAlignment = .left
        self.fatLabel.textColor = .black
        self.fatLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.fatLabel.numberOfLines = -1
        self.addSubview(self.fatLabel)
        
        self.saturatedFatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.saturatedFatLabel.text = "포화지방 : " + String(describing: foodInfo.saturatedFat!)
        self.saturatedFatLabel.textAlignment = .left
        self.saturatedFatLabel.textColor = .black
        self.saturatedFatLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.saturatedFatLabel.numberOfLines = -1
        self.addSubview(self.saturatedFatLabel)
        
        self.transFatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.transFatLabel.text = "트랜스지방 : " + String(describing: foodInfo.transFat!)
        self.transFatLabel.textAlignment = .left
        self.transFatLabel.textColor = .black
        self.transFatLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.transFatLabel.numberOfLines = -1
        self.addSubview(self.transFatLabel)
        
        self.cholesterolLabel.translatesAutoresizingMaskIntoConstraints = false
        self.cholesterolLabel.text = "콜레스테롤 : " + String(describing: foodInfo.cholesterol!)
        self.cholesterolLabel.textAlignment = .left
        self.cholesterolLabel.textColor = .black
        self.cholesterolLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.cholesterolLabel.numberOfLines = -1
        self.addSubview(self.cholesterolLabel)
        
        self.sodiumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sodiumLabel.text = "나트륨 : " + String(describing: foodInfo.sodium!)
        self.sodiumLabel.textAlignment = .left
        self.sodiumLabel.textColor = .black
        self.sodiumLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.sodiumLabel.numberOfLines = -1
        self.addSubview(self.sodiumLabel)
        
        self.foodCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.foodCountLabel.text = "냉장고 수량 : " + String(describing: self.foodCount)
        self.foodCountLabel.textAlignment = .left
        self.foodCountLabel.textColor = .black
        self.foodCountLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.foodCountLabel.numberOfLines = -1
        self.addSubview(self.foodCountLabel)
        
        NSLayoutConstraint.activate([
            self.foodImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.foodImageView.widthAnchor.constraint(equalToConstant: 150),
            self.foodImageView.heightAnchor.constraint(equalToConstant: 150),
            
            self.foodNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.foodNameLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.foodNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.caloriesLabel.topAnchor.constraint(equalTo: self.foodNameLabel.bottomAnchor, constant: 2),
            self.caloriesLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.caloriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.carbohydratesLabel.topAnchor.constraint(equalTo: self.caloriesLabel.bottomAnchor, constant: 2),
            self.carbohydratesLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.carbohydratesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.sugarsLabel.topAnchor.constraint(equalTo: self.carbohydratesLabel.bottomAnchor, constant: 2),
            self.sugarsLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.sugarsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.proteinLabel.topAnchor.constraint(equalTo: self.sugarsLabel.bottomAnchor, constant: 2),
            self.proteinLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.proteinLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.fatLabel.topAnchor.constraint(equalTo: self.proteinLabel.bottomAnchor, constant: 2),
            self.fatLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.fatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.saturatedFatLabel.topAnchor.constraint(equalTo: self.fatLabel.bottomAnchor, constant: 2),
            self.saturatedFatLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.saturatedFatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.transFatLabel.topAnchor.constraint(equalTo: self.saturatedFatLabel.bottomAnchor, constant: 2),
            self.transFatLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.transFatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.cholesterolLabel.topAnchor.constraint(equalTo: self.transFatLabel.bottomAnchor, constant: 2),
            self.cholesterolLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.cholesterolLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.sodiumLabel.topAnchor.constraint(equalTo: self.cholesterolLabel.bottomAnchor, constant: 2),
            self.sodiumLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.sodiumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.foodCountLabel.topAnchor.constraint(equalTo: self.sodiumLabel.bottomAnchor, constant: 10),
            self.foodCountLabel.leadingAnchor.constraint(equalTo: self.foodImageView.trailingAnchor, constant: 5),
            self.foodCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // TODO: ...
    }
    
    @objc func viewTapped() {
        
        AnimationHelper.instance.startViewSpringAnimation(view: self, duration: 0.5, scale: 1.05)
        
        self.viewTappedCommand()
    }
    
}
