//
//  ReservationViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/28/24.
//

import UIKit

class AlertButtonViewController: UIViewController {
    
    // UI Element
    let outerView = UIView()
    let mainTitleLabel = UILabel()
    let subTitleLabel = UILabel()
    let reserveNoButton = UIButton()
    let reserveYesButton = UIButton()
    
    let yesClickCallback : () -> Void
    let noClickCallback : () -> Void
    
    init(mainTitle: String, subTitle: String, yesClickCallback: @escaping (() -> Void), noClickCallback: @escaping (() -> Void)) {
        
        self.yesClickCallback = yesClickCallback
        self.noClickCallback = noClickCallback
        super.init(nibName: nil, bundle: nil)
        
        self.mainTitleLabel.text = mainTitle
        self.mainTitleLabel.numberOfLines = -1
        
        self.subTitleLabel.text = subTitle
        self.subTitleLabel.numberOfLines = -1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.layer.cornerRadius = 8
        self.outerView.layer.masksToBounds = true
        self.outerView.layer.borderWidth = 1
        self.outerView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        self.outerView.backgroundColor = .white
        self.view.addSubview(self.outerView)
        
        self.mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainTitleLabel.textAlignment = .center
        self.mainTitleLabel.textColor = .black
        self.mainTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.view.addSubview(self.mainTitleLabel)
        
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subTitleLabel.textAlignment = .center
        self.subTitleLabel.textColor = .black
        self.subTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.view.addSubview(self.subTitleLabel)
        
        self.reserveYesButton.translatesAutoresizingMaskIntoConstraints = false
        // self.reserveYesButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.reserveYesButton.layer.cornerRadius = 8
        self.reserveYesButton.layer.masksToBounds = true
        self.reserveYesButton.setTitle("예", for: .normal)
        self.reserveYesButton.setTitleColor(.black, for: .normal)
        self.reserveYesButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.reserveYesButton.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.reserveYesButton)
        
        self.reserveNoButton.translatesAutoresizingMaskIntoConstraints = false
        // self.reserveNoButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.reserveNoButton.layer.cornerRadius = 8
        self.reserveNoButton.layer.masksToBounds = true
        self.reserveNoButton.setTitle("아니오", for: .normal)
        self.reserveNoButton.setTitleColor(.black, for: .normal)
        self.reserveNoButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.reserveNoButton.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.reserveNoButton)
        
        NSLayoutConstraint.activate([
            self.outerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.outerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.outerView.widthAnchor.constraint(equalToConstant: 350),
            self.outerView.heightAnchor.constraint(equalToConstant: 200),
            
            self.mainTitleLabel.topAnchor.constraint(equalTo: self.outerView.topAnchor, constant: 20),
            self.mainTitleLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 10),
            self.mainTitleLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -10),
            
            self.subTitleLabel.topAnchor.constraint(equalTo: self.mainTitleLabel.bottomAnchor, constant: 10),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 10),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -10),
            
            self.reserveYesButton.bottomAnchor.constraint(equalTo: self.outerView.bottomAnchor, constant: -10),
            self.reserveYesButton.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 20),
            self.reserveYesButton.trailingAnchor.constraint(equalTo: self.outerView.centerXAnchor, constant: -20),
            self.reserveYesButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.reserveNoButton.bottomAnchor.constraint(equalTo: self.outerView.bottomAnchor, constant: -10),
            self.reserveNoButton.leadingAnchor.constraint(equalTo: self.outerView.centerXAnchor, constant: 20),
            self.reserveNoButton.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -20),
            self.reserveNoButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    @objc func yesButtonClicked(_ sender: UIButton) {
        // 예약 진행
        self.dismiss(animated: true, completion: self.yesClickCallback)
    }
    
    @objc func noButtonClicked(_ sender: UIButton) {
        self.noClickCallback()
        self.dismiss(animated: true)
    }
}
