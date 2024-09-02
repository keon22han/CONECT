//
//  SmallReservationInformationView.swift
//  MarketProject
//
//  Created by 한건희 on 8/28/24.
//

import Foundation
import UIKit

class SmallReservationInformationView: UIView {
    
    let shareTableReservationInfo : ShareTableReservationInfo
    
    let leftAvailableBar = UIView()
    let tableLabel = UILabel()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    
    init(isAvailable: Bool, shareTableReservationInfo: ShareTableReservationInfo) {
        self.shareTableReservationInfo = shareTableReservationInfo
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setUpView(isAvailable: isAvailable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(isAvailable: Bool) {
        
        if isAvailable {
            self.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(isViewTapped))
            self.addGestureRecognizer(tapGestureRecognizer)
        }
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.leftAvailableBar.translatesAutoresizingMaskIntoConstraints = false
        self.leftAvailableBar.layer.cornerRadius = 2
        self.leftAvailableBar.layer.masksToBounds = true
        
        if isAvailable {
            self.leftAvailableBar.backgroundColor = .green
        } else {
            self.leftAvailableBar.backgroundColor = .red
        }
        self.addSubview(self.leftAvailableBar)
        
        let tableStringList = ["TableA", "TableB", "TableC", "TableD"]
        
        self.tableLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tableLabel.text = tableStringList[shareTableReservationInfo.tableNumber!]
        self.tableLabel.textColor = .black
        self.tableLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
        self.tableLabel.textAlignment = .left
        self.addSubview(self.tableLabel)

        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.text = shareTableReservationInfo.date!
        self.dateLabel.textColor = .black
        self.dateLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
        self.dateLabel.textAlignment = .left
        self.addSubview(self.dateLabel)
        
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.text = shareTableReservationInfo.time!
        self.timeLabel.textColor = .black
        self.timeLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
        self.timeLabel.textAlignment = .left
        self.addSubview(self.timeLabel)
        
        NSLayoutConstraint.activate([
            self.leftAvailableBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.leftAvailableBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.leftAvailableBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.leftAvailableBar.widthAnchor.constraint(equalToConstant: 3),
            
            self.tableLabel.topAnchor.constraint(equalTo: self.leftAvailableBar.topAnchor, constant: 5),
            self.tableLabel.leadingAnchor.constraint(equalTo: self.leftAvailableBar.trailingAnchor, constant: 5),
            
            self.dateLabel.centerYAnchor.constraint(equalTo: self.leftAvailableBar.centerYAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leftAvailableBar.trailingAnchor, constant: 5),
            
            self.timeLabel.bottomAnchor.constraint(equalTo: self.leftAvailableBar.bottomAnchor, constant: -5),
            self.timeLabel.leadingAnchor.constraint(equalTo: self.leftAvailableBar.trailingAnchor, constant: 5)
        ])
    }
    
    @objc func isViewTapped() {
        let alertButtonViewController = AlertButtonViewController(mainTitle: "해당 예약을 취소하시겠습니까?", subTitle: "", yesClickCallback: {
            DBManager.instance.cancelSingleReservation(tableNumber: self.shareTableReservationInfo.tableNumber!, reservedDate: self.shareTableReservationInfo.date!, reservedTime: self.shareTableReservationInfo.time!, completion: {
                DispatchQueue.main.async {
                    (self.findViewController() as! SettingTabViewController).setReservationInformation()
                }
            })
        }, noClickCallback: {
        })
        
        alertButtonViewController.modalPresentationStyle = .overFullScreen
        alertButtonViewController.modalTransitionStyle = .crossDissolve
        
        self.findViewController()?.present(alertButtonViewController, animated: true)
    }
    
}
