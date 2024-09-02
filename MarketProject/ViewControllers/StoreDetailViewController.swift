//
//  StoreDetailViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/28/24.
//

import UIKit

class StoreDetailViewController: UIViewController {

    let outerView = UIView()
    let exitButton = UIButton()
    let detailLabel = UILabel()
    
    init(detailText: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.detailLabel.text = detailText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.layer.cornerRadius = 10
        self.outerView.layer.masksToBounds = true
        self.outerView.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 0.8)
        self.view.addSubview(self.outerView)

        self.exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.exitButton.layer.cornerRadius = 10
        self.exitButton.layer.masksToBounds = true
        self.exitButton.backgroundColor = .white
        self.exitButton.setImage(UIImage(named: "exit")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        self.outerView.addSubview(self.exitButton)
        
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailLabel.textAlignment = .center
        self.detailLabel.textColor = .white
        self.detailLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        self.outerView.addSubview(self.detailLabel)
        
        NSLayoutConstraint.activate([
            self.outerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.outerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.outerView.widthAnchor.constraint(equalToConstant: 300),
            self.outerView.heightAnchor.constraint(equalToConstant: 300),
            
            self.exitButton.topAnchor.constraint(equalTo: self.outerView.topAnchor, constant: 10),
            self.exitButton.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -10),
            self.exitButton.widthAnchor.constraint(equalToConstant: 40),
            self.exitButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.detailLabel.centerYAnchor.constraint(equalTo: self.outerView.centerYAnchor),
            self.detailLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor),
            self.detailLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor)
        ])
    }
    
    @objc func exitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
