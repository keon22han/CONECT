//
//  AlertView.swift
//  MarketProject
//
//  Created by 한건희 on 8/26/24.
//

import Foundation
import UIKit

class AlertView: UIView {
    
    private let exitButton = UIButton()
    private let alertLabel = UILabel()
    private let alertImageView = UIImageView()
    
    init(alertString: String, alertImage: UIImage) {
        
        self.alertLabel.text = alertString
        self.alertImageView.image = alertImage
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.exitButton.setImage(UIImage(named: "exit")!.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        self.addSubview(self.exitButton)
        
        self.alertLabel.translatesAutoresizingMaskIntoConstraints = false
        self.alertLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        self.alertLabel.textColor = .black
        self.alertLabel.numberOfLines = -1
        self.alertLabel.textAlignment = .center
        self.addSubview(self.alertLabel)
        
        self.alertImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.alertImageView)
        
        NSLayoutConstraint.activate([
            self.exitButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.exitButton.heightAnchor.constraint(equalToConstant: 40),
            self.exitButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.alertImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.alertImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.alertImageView.heightAnchor.constraint(equalToConstant: 100),
            self.alertImageView.widthAnchor.constraint(equalToConstant: 100),
            
            self.alertLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.alertLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.alertLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.alertLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func exitButtonClicked(_ sender: UIButton) {
        self.findViewController()?.dismiss(animated: true)
    }
    
}
