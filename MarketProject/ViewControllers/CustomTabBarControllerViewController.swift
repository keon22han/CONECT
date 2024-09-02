//
//  CustomTabBarControllerViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/11/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTabBarItems()
        // 만약 Y축을 옮겨준다면, 아래 imageInsets의 크기도 Y축에 맞게 변경해줘야 합니다.
        setupTabBar(eachSide: 60, height: 60, y: 20)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // 탭한 인덱스 찾기
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap ({ $0 as? UIImageView}).first else {
            return
        }
        
        performSpringAnimation(imgView: imageView)
    }
    
    // 이미지뷰에 스프링 애니메이션 적용하기
    func performSpringAnimation(imgView: UIImageView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            imgView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
            
        }
    }
    
    // MARK: - TabBar Item Setup
    func setupTabBarItems() {
        let mapViewController = SellerListTabViewController()
        mapViewController.tabBarItem.image = UIImage(named: "market-unselected")?.resized(to: CGSize(width: 30, height: 30))
        mapViewController.tabBarItem.selectedImage = UIImage(named: "market-selected")?.resized(to: CGSize(width: 30, height: 30))
        
        let settingViewController = SettingTabViewController()
        settingViewController.tabBarItem.image = UIImage(named: "setting-unselected")?.resized(to: CGSize(width: 40, height: 40))
        settingViewController.tabBarItem.selectedImage = UIImage(named: "setting-selected")?.resized(to: CGSize(width: 40, height: 40))
        //
        let shareViewController = ShareViewController()
        shareViewController.tabBarItem.image = UIImage(named: "share-unselected")?.resized(to: CGSize(width: 30, height: 30))
        
        shareViewController.tabBarItem.selectedImage = UIImage(named: "share-selected")?.resized(to: CGSize(width: 30, height: 30))
        
        let secondHandViewController = SecondHandViewController()
        secondHandViewController.tabBarItem.image = UIImage(named: "secondhand-unselected")?.resized(to: CGSize(width: 40, height: 45))
        
        secondHandViewController.tabBarItem.selectedImage = UIImage(named: "secondhand-selected")?.resized(to: CGSize(width: 35, height: 45))
        
        viewControllers = [mapViewController, shareViewController, secondHandViewController, settingViewController]
        
        for item in tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        }
    }
    
    // MARK: - Layer Setup
    func setupTabBar(eachSide space: CGFloat, height: CGFloat, y: CGFloat = 0) {
        // CAShapeLayer 객체 생성
        let layer = CAShapeLayer()
        
        // tab bar layer 세팅
        let x: CGFloat = space                              // X 축으로 이동한 거리 (여백)
        let width: CGFloat = tabBar.bounds.width - (x*2)    // 너비: 기본 탭바의 너비 - (여백 * 2)
        let height: CGFloat = height                        // 높이
        let centerImageY: CGFloat = 19 - (height/2)         // 이미지 중심을 탭바의 원점으로 이동(19) - (높이/2)
        let y: CGFloat = centerImageY + y                   // Y축: 변화된 높이 + 원하는 Y축 위치
      
        // 알약 모양으로 UIBezierPath 생성
        let frame: CGRect = CGRect(x: x, y: y, width: width, height: height)
        let path = UIBezierPath(roundedRect: frame,
                                cornerRadius: height/3).cgPath
        layer.path = path

        layer.fillColor = UIColor.white.cgColor
        
        // tab bar layer 그림자 설정
        layer.shadowColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)  // 밑면 그림자 크기
        layer.shadowRadius = 4.0                              // 흐려지는 반경
        layer.shadowOpacity = 0.7                             // 불투명도 (0 ~ 1)
        
        // tab bar layer 삽입: addSublayer대신 insertSublayer(0번째 Sublayer에 대치) 사용
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // Bar 그림자 제거
        appearance.stackedItemWidth = width / 8
        appearance.stackedItemPositioning = .centered
        // tab bar items의 위치 설정
        self.tabBar.standardAppearance = appearance
        
        // 틴트 컬러 설정
        self.tabBar.tintColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        
        self.tabBar.backgroundColor = .clear
    }
}
