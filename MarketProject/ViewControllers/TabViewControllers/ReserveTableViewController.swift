//
//  ReserveTableView.swift
//  MarketProject
//
//  Created by 한건희 on 8/25/24.
//

import Foundation
import UIKit

// 09, 11, 13, 15, 17, 19
class ReserveTableViewController: UIViewController {
    
    var date: String?
    var tableNumber: Int?
    
    // TODO: TimeView 클릭 시 해당 
    let leftTopView = TimeView()
    let middleTopView = TimeView()
    let rightTopView = TimeView()
    let leftBottomView = TimeView()
    let middleBottomView = TimeView()
    let rightBottomView = TimeView()
    
    var timeViewTopOffset = 50.0
    
    init(date: String, tableNumber: Int) {
        super.init(nibName: nil, bundle: nil)
        self.date = date
        self.tableNumber = tableNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.backgroundColor = .white
        outerView.layer.cornerRadius = 10
        outerView.layer.masksToBounds = true
        self.view.addSubview(outerView)
        
        let quitButton = UIButton()
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.setImage(UIImage(named: "exit")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        quitButton.addTarget(self, action: #selector(quitButtonClicked), for: .touchUpInside)
        outerView.addSubview(quitButton)
        
        let dateDescriptionLabel = UILabel()
        dateDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateDescriptionLabel.textAlignment = .center
        dateDescriptionLabel.text = "\(self.date!) 자리 현황입니다."
        dateDescriptionLabel.textColor = .black
        dateDescriptionLabel.font = UIFont(name: "Pretendard-Medium", size: 18)
        outerView.addSubview(dateDescriptionLabel)
        
        self.leftTopView.setDate(date: self.date!)
        self.middleTopView.setDate(date: self.date!)
        self.rightTopView.setDate(date: self.date!)
        self.leftBottomView.setDate(date: self.date!)
        self.middleBottomView.setDate(date: self.date!)
        self.rightBottomView.setDate(date: self.date!)
        
        self.leftTopView.translatesAutoresizingMaskIntoConstraints = false
        self.middleTopView.translatesAutoresizingMaskIntoConstraints = false
        self.rightTopView.translatesAutoresizingMaskIntoConstraints = false
        self.leftBottomView.translatesAutoresizingMaskIntoConstraints = false
        self.middleBottomView.translatesAutoresizingMaskIntoConstraints = false
        self.rightBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        outerView.addSubview(leftTopView)
        outerView.addSubview(middleTopView)
        outerView.addSubview(rightTopView)
        outerView.addSubview(leftBottomView)
        outerView.addSubview(middleBottomView)
        outerView.addSubview(rightBottomView)
        
        NSLayoutConstraint.activate([
            quitButton.topAnchor.constraint(equalTo: outerView.topAnchor, constant: 5),
            quitButton.trailingAnchor.constraint(equalTo: outerView.trailingAnchor, constant: -5),
            quitButton.widthAnchor.constraint(equalToConstant: 40),
            quitButton.heightAnchor.constraint(equalToConstant: 40),
            
            outerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            outerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            outerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            outerView.heightAnchor.constraint(equalToConstant: 250),
            
            dateDescriptionLabel.centerYAnchor.constraint(equalTo: quitButton.centerYAnchor),
            dateDescriptionLabel.leadingAnchor.constraint(equalTo: outerView.leadingAnchor, constant: 10),
            dateDescriptionLabel.trailingAnchor.constraint(equalTo: quitButton.leadingAnchor, constant: -10),
            
            self.leftTopView.topAnchor.constraint(equalTo: outerView.topAnchor, constant: self.timeViewTopOffset),
            self.leftTopView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor, constant: 10),
            self.leftTopView.widthAnchor.constraint(equalToConstant: 60),
            self.leftTopView.heightAnchor.constraint(equalToConstant: 90),
            
            self.middleTopView.centerXAnchor.constraint(equalTo: outerView.centerXAnchor),
            self.middleTopView.topAnchor.constraint(equalTo: outerView.topAnchor, constant: self.timeViewTopOffset),
            self.middleTopView.widthAnchor.constraint(equalToConstant: 60),
            self.middleTopView.heightAnchor.constraint(equalToConstant: 90),
            
            self.rightTopView.topAnchor.constraint(equalTo: outerView.topAnchor, constant: self.timeViewTopOffset),
            self.rightTopView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor, constant: -10),
            self.rightTopView.widthAnchor.constraint(equalToConstant: 60),
            self.rightTopView.heightAnchor.constraint(equalToConstant: 90),
            
            self.leftBottomView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor, constant: -10),
            self.leftBottomView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor, constant: 10),
            self.leftBottomView.widthAnchor.constraint(equalToConstant: 60),
            self.leftBottomView.heightAnchor.constraint(equalToConstant: 90),
            
            self.middleBottomView.centerXAnchor.constraint(equalTo: outerView.centerXAnchor),
            self.middleBottomView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor, constant: -10),
            self.middleBottomView.widthAnchor.constraint(equalToConstant: 60),
            self.middleBottomView.heightAnchor.constraint(equalToConstant: 90),
            
            self.rightBottomView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor, constant: -10),
            self.rightBottomView.trailingAnchor.constraint(equalTo: outerView.trailingAnchor, constant: -10),
            self.rightBottomView.widthAnchor.constraint(equalToConstant: 60),
            self.rightBottomView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    // isAvailables에 false 로 되어있는 인덱스에 해당하는 reservedUserInfo 제외 나머지 nil값 저장
    public func setTimeViews(isAvailables: [String: Bool], date: String, reservedUsersInfo: [String: User?]) {
        
        self.leftTopView.setTimeView(isAvailable: isAvailables["09:00"]!, time: "09:00", reservedUserInfo: reservedUsersInfo["09:00"]!)
        self.middleTopView.setTimeView(isAvailable: isAvailables["11:00"]!, time: "11:00", reservedUserInfo: reservedUsersInfo["11:00"]!)
        self.rightTopView.setTimeView(isAvailable: isAvailables["13:00"]!, time: "13:00", reservedUserInfo: reservedUsersInfo["13:00"]!)
        self.leftBottomView.setTimeView(isAvailable: isAvailables["15:00"]!, time: "15:00", reservedUserInfo: reservedUsersInfo["15:00"]!)
        self.middleBottomView.setTimeView(isAvailable: isAvailables["17:00"]!, time: "17:00", reservedUserInfo: reservedUsersInfo["17:00"]!)
        self.rightBottomView.setTimeView(isAvailable: isAvailables["19:00"]!, time: "19:00", reservedUserInfo:  reservedUsersInfo["19:00"]!)
    }
    
    @objc func quitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
