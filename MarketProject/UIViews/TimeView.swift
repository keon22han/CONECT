//
//  TimeView.swift
//  MarketProject
//
//  Created by 한건희 on 8/25/24.
//

import Foundation
import UIKit

class TimeView: UIView {
    
    private var date: String?
    private var reservedUserInfo: User?
    
    private var isAvailable = true
    private var time = "time"
    private let availableImageView = UIImageView(image: UIImage(named: "circle-green"))
    private let timeLabel = UILabel()
    
    private var reserveViewController: AlertButtonViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpView))
        
        self.addGestureRecognizer(gestureRecognizer)
        
        self.availableImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.availableImageView)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.text = self.time
        self.timeLabel.textColor = .black
        self.timeLabel.textAlignment = .center
        self.timeLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.addSubview(self.timeLabel)
        
        NSLayoutConstraint.activate([
            self.availableImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.availableImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.availableImageView.widthAnchor.constraint(equalToConstant: 30),
            self.availableImageView.heightAnchor.constraint(equalToConstant: 30),
            
            self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTimeView(isAvailable: Bool, time: String, reservedUserInfo: User?) {
        self.isAvailable = isAvailable
        
        if isAvailable {
            self.availableImageView.image = UIImage(named: "green-circle")
        } else {
            self.availableImageView.image = UIImage(named: "red-circle")
        }
        
        if DBManager.instance.getUserId() == reservedUserInfo?.userDBId {
            self.availableImageView.image = UIImage(named: "user-default")
        }
        
        self.timeLabel.text = time
        self.time = time
        self.reservedUserInfo = reservedUserInfo
    }
    
    public func setDate(date: String) {
        self.date = date
    }
    
    @objc func touchUpView() {
        
        AnimationHelper.instance.startViewSpringAnimation(view: self, duration: 0.5, scale: 1.1)
        
    
        Task {
            DispatchQueue.main.async {
                self.backgroundColor = .gray
            }
            
            do {
                try await Task.sleep(nanoseconds: 100000000)
            }
            
            DispatchQueue.main.async {
                self.backgroundColor = .clear
            }
        }
        
        // TODO: 예약이 비어있다면 진행할 것인지? 또는 예약이 되어있다면 어느 유저가 해당 예약을 진행했는지에 대한 Information View
        if self.isAvailable {
            // TODO: 예약 창 나오게
            showReservationView()
        } else {
            // TODO: 예약한 유저 정보 뜨게 (1. 본인 예약 시간인 경우, 2. 타 유저 예약 시간)
            showReservedUserInfo()
        }
    }
    
    func showReservationView() {
        // Reservation Viewcontroller Present
        let tableLabelList = ["A", "B", "C", "D"]
        let mainTitle = "\(tableLabelList[(self.findViewController() as! ReserveTableViewController).tableNumber!]) 테이블 \(self.date!) \(self.time)"
        let subTitle = "예약하시겠습니까?"
        
        self.reserveViewController = AlertButtonViewController(mainTitle: mainTitle, subTitle: subTitle, yesClickCallback: {
            let tableReserveInfo = ShareTableReservationInfo(reserverDBId: DBManager.instance.getUserId(), tableNumber: (self.findViewController() as! ReserveTableViewController).tableNumber!, date: self.date!, time: self.time)
            
            DBManager.instance.reserveSharedTable(tableInfo: tableReserveInfo)
            
            self.updateTimeView(isAvailable: false, availableImage: UIImage(named: "user-default")!)
            }
        , noClickCallback: {
            print("reserve canceled")
        })
        
        self.reserveViewController!.modalPresentationStyle = .overFullScreen
        self.reserveViewController!.modalTransitionStyle = .crossDissolve
        
        self.findViewController()!.present(reserveViewController!, animated: true)
    }
    
    func showReservedUserInfo() {
        // 본인 예약 시간일 경우
        if self.reservedUserInfo?.userDBId == DBManager.instance.getUserId() {
            let reservedUserInfoViewController = AlertButtonViewController(mainTitle: "회원님께서 예약하신 시간입니다.", subTitle: "예약을 취소하시겠습니까?", yesClickCallback: {
                DBManager.instance.cancelSingleReservation(tableNumber: (self.findViewController() as! ReserveTableViewController).tableNumber!, reservedDate: self.date!, reservedTime: self.time, completion: {}) 
                self.updateTimeView(isAvailable: true, availableImage: UIImage(named: "green-circle")!)
            }, noClickCallback: {
                print("예약 유지")
            })
            reservedUserInfoViewController.modalPresentationStyle = .overFullScreen
            reservedUserInfoViewController.modalTransitionStyle = .crossDissolve
            self.findViewController()!.present(reservedUserInfoViewController, animated: true)
        }
        // 타 유저 예약 시간일 경우
        else {
            let reservedUserInfoViewController = UIViewController()
            reservedUserInfoViewController.view.backgroundColor = .clear
            reservedUserInfoViewController.modalPresentationStyle = .overFullScreen
            reservedUserInfoViewController.modalTransitionStyle = .crossDissolve
            
            
            let alertView = AlertView(alertString: "타 유저가 예약한 시간입니다.", alertImage: UIImage(named: "alert")!)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            alertView.layer.borderColor = UIColor.black.cgColor
            alertView.layer.borderWidth = 1
            reservedUserInfoViewController.view.addSubview(alertView)
            
            NSLayoutConstraint.activate([
                alertView.centerXAnchor.constraint(equalTo: reservedUserInfoViewController.view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: reservedUserInfoViewController.view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(equalToConstant: 300)
            ])
            
            self.findViewController()?.present(reservedUserInfoViewController, animated: true)
        }
    }
    
    func updateTimeView(isAvailable: Bool, availableImage: UIImage) {
        // View Update
        self.isAvailable = isAvailable
        self.availableImageView.image = availableImage
        
        if !isAvailable {
            DBManager.instance.getUserInformation(userDBId: DBManager.instance.getUserId()) { exist , user in
                self.reservedUserInfo = user
            }
        } else {
            self.reservedUserInfo = nil
        }
    }
}
