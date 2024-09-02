//
//  RefrigeratorFoodsInfoStackView.swift
//  MarketProject
//
//  Created by 한건희 on 8/31/24.
//

import Foundation
import UIKit

class RefrigeratorFoodsInfoStackView: UIStackView {
    
    let refrigeratorInfo : RefrigeratorInformation
    
    init(refrigeratorInfo: RefrigeratorInformation) {
        self.refrigeratorInfo = refrigeratorInfo
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 20
        self.distribution = .equalSpacing
        
        getRefrigeratorFoodsInfo()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getRefrigeratorFoodsInfo() {
        let refrigeratorFoodsInfo = self.refrigeratorInfo.getFoodsInfo()
        
        for (refrigeratorFoodName, refrigeratorFoodCount) in refrigeratorFoodsInfo {
            
            DBManager.instance.getFoodInfo(foodName: refrigeratorFoodName, completion: { foodInfo in
                if foodInfo == nil {
                    return
                }
                
                // refrigerator의 이름에 해당하는 SegmentControl 탭에 대해 StackView에 음식 정보 불러와 앞에서 가져온 냉장고의 해당 음식 카운트를 추가하여 UI 생성하고 추가
                let foodInfoView = FoodInfoView(foodInfo: foodInfo!, foodCount: refrigeratorFoodCount, viewTappedCommand: {
                    
                    // TODO: Recommand Food Recipe 창 보여주기 (2024.09.01)
                    
                    let loadingViewController = LoadingViewController()
                    loadingViewController.modalTransitionStyle = .crossDissolve
                    loadingViewController.modalPresentationStyle = .overFullScreen
                    
                    self.findViewController()!.present(loadingViewController, animated: true)
                    
                    // TODO: 수정 필요. 코드 잘못 작성한 것 같음 (2024.09.01)
                    let _ = RecommandFoodRecipesViewController(superViewController: self.findViewController()!, foodName: refrigeratorFoodName, recommandRecipeCount: 10, loadCompleteCommand: {
                        loadingViewController.dismiss(animated: true)
                    })
                    
                })
                
                DispatchQueue.main.async {
                    foodInfoView.translatesAutoresizingMaskIntoConstraints = false
                    self.addArrangedSubview(foodInfoView)
                    
                    NSLayoutConstraint.activate([
                        foodInfoView.widthAnchor.constraint(equalToConstant: 350),
                        foodInfoView.heightAnchor.constraint(equalToConstant: 220)
                    ])
                }
            })
        }
    }
    
    
}
