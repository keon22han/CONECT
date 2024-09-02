//
//  ShoppingCartReservationViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/30/24.
//

import UIKit

class ShoppingCartReservationViewController: UIViewController {
    
    private let outerView = UIView()
    private let shoppingCartImageView = UIImageView()
    private let checkUsingLabel = UILabel()
    private let yesButton = UIButton()
    private let noButton = UIButton()
    
    private let yesCommand: () -> Void
    private let noCommand: () -> Void
    
    init(yesCommand: @escaping () -> Void, noCommand: @escaping () -> Void) {
        self.yesCommand = yesCommand
        self.noCommand = noCommand
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.backgroundColor = .white
        self.outerView.layer.cornerRadius = 10
        self.outerView.layer.masksToBounds = true
        self.view.addSubview(self.outerView)

        self.shoppingCartImageView.translatesAutoresizingMaskIntoConstraints = false
        self.shoppingCartImageView.image = UIImage(named: "shopping-cart")
        self.outerView.addSubview(self.shoppingCartImageView)
        
        self.checkUsingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.checkUsingLabel.text = "해당 장바구니를 이용하시겠습니까?"
        self.checkUsingLabel.numberOfLines = -1
        self.checkUsingLabel.textAlignment = .center
        self.checkUsingLabel.textColor = .black
        self.checkUsingLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.outerView.addSubview(self.checkUsingLabel)
        
        self.yesButton.translatesAutoresizingMaskIntoConstraints = false
        self.yesButton.setTitle("예", for: .normal)
        self.yesButton.setTitleColor(UIColor.black, for: .normal)
        self.yesButton.addTarget(self, action: #selector(yesButtonClicked), for: .touchUpInside)
        self.outerView.addSubview(self.yesButton)
        
        self.noButton.translatesAutoresizingMaskIntoConstraints = false
        self.noButton.setTitle("아니오", for: .normal)
        self.noButton.setTitleColor(UIColor.black, for: .normal)
        self.noButton.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
        self.outerView.addSubview(self.noButton)
        
        NSLayoutConstraint.activate([
            self.outerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.outerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.outerView.widthAnchor.constraint(equalToConstant: 300),
            self.outerView.heightAnchor.constraint(equalToConstant: 300),
            
            self.shoppingCartImageView.topAnchor.constraint(equalTo: self.outerView.topAnchor, constant: 20),
            self.shoppingCartImageView.centerXAnchor.constraint(equalTo: self.outerView.centerXAnchor),
            self.shoppingCartImageView.widthAnchor.constraint(equalToConstant: 100),
            self.shoppingCartImageView.heightAnchor.constraint(equalToConstant: 100),
            
            self.checkUsingLabel.topAnchor.constraint(equalTo: self.shoppingCartImageView.bottomAnchor, constant: 10),
            self.checkUsingLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 5),
            self.checkUsingLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -5),
            
            self.yesButton.bottomAnchor.constraint(equalTo: self.outerView.bottomAnchor, constant: -20),
            self.yesButton.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 20),
            self.yesButton.trailingAnchor.constraint(equalTo: self.outerView.centerXAnchor, constant: -20),
            self.yesButton.heightAnchor.constraint(equalToConstant: 30),
            
            self.noButton.bottomAnchor.constraint(equalTo: self.outerView.bottomAnchor, constant: -20),
            self.noButton.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -20),
            self.noButton.leadingAnchor.constraint(equalTo: self.outerView.centerXAnchor, constant: 20),
            self.noButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func yesButtonClicked(_ sender: UIButton) {
        self.yesCommand()
        self.dismiss(animated: true)
    }

    @objc func noButtonClicked(_ sender: UIButton) {
        self.noCommand()
        self.dismiss(animated: true)
    }
}
