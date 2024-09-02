//
//  ShareViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/21/24.
//

import UIKit

// 공유 키친, 공유 냉장고 관련 뷰 컨트롤러 (테이블 총 4개 중 예약 가능 여부 및 예약 기능, 냉장고 내용물 확인 가능)
class ShareViewController: UIViewController {

    let uiSegmentedControl = UISegmentedControl()
    var pageViewController: SharedPageViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = SharedPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.setSegmentedControl(uiSegmentedControl: self.uiSegmentedControl)
        
        // -> pageViewController.setViewControllers()
        guard let pageViewController = pageViewController else {
            return
        }
        
        addChild(pageViewController)
        
        self.uiSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.uiSegmentedControl.insertSegment(withTitle: "공유 주방", at: 0, animated: true)
        self.uiSegmentedControl.insertSegment(withTitle: "공유 냉장고", at: 1, animated: true)
        self.uiSegmentedControl.selectedSegmentIndex = 0
        self.uiSegmentedControl.selectedSegmentTintColor = .white
        self.uiSegmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Pretendard-Medium", size: 10)!
        ]
        
        self.uiSegmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        
        self.view.addSubview(self.uiSegmentedControl)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageViewController.view)
        
        
        
        
        NSLayoutConstraint.activate([
            self.uiSegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            self.uiSegmentedControl.heightAnchor.constraint(equalToConstant: 25),
            self.uiSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.uiSegmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pageViewController.view.topAnchor.constraint(equalTo: self.uiSegmentedControl.bottomAnchor, constant: 10),
            pageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        let nextVC = pageViewController!.PageViewControllerList[sender.selectedSegmentIndex]
        
        if sender.selectedSegmentIndex == 0 {
            pageViewController?.setViewControllers([nextVC], direction: .reverse, animated: true, completion: nil)
            return
        }
        pageViewController?.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
}
