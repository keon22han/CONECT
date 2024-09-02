//
//  SetSearchingKeywordViewController.swift
//  MarketProject
//
//  Created by 한건희 on 9/2/24.
//

import UIKit

class SetSearchingKeywordViewController: UIViewController {
    
    let searchButtonCommand: (String) -> Void
    let exitButtonCommand: () -> Void
    
    let outerView = UIView()
    let searchImageView = UIImageView()
    let keywordTextField = UITextField()
    let searchButton = UIButton()
    let exitButton = UIButton()
    
    init(searchButtonCommand: @escaping((String) -> Void), exitButtonCommand: @escaping(() -> Void)) {
        self.searchButtonCommand = searchButtonCommand
        self.exitButtonCommand = exitButtonCommand
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupKeyboardNotification()
        
        self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        
        
        self.exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.searchImageView.translatesAutoresizingMaskIntoConstraints = false
        self.keywordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.exitButton.setImage(UIImage(named: "exit-circle")?.resized(to: CGSize(width: 80, height: 80)), for: .normal)
        self.exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.exitButton)
        
        self.outerView.backgroundColor = .white
        self.outerView.layer.cornerRadius = 30
        self.outerView.layer.masksToBounds = true
        self.view.addSubview(self.outerView)
        
        self.searchImageView.image = UIImage(named: "search-simple")
        self.view.addSubview(self.searchImageView)
        
        self.keywordTextField.placeholder = "검색어를 입력해주세요."
        self.keywordTextField.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.keywordTextField.borderStyle = .roundedRect
        self.keywordTextField.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.view.addSubview(self.keywordTextField)
        
        self.searchButton.setTitle(" 검색 ", for: .normal)
        self.searchButton.layer.cornerRadius = 12
        self.searchButton.layer.masksToBounds = true
        self.searchButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.searchButton.setTitleColor(.white, for: .normal)
        self.searchButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.searchButton)
        
        NSLayoutConstraint.activate([
            self.exitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            self.exitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.exitButton.widthAnchor.constraint(equalToConstant: 60),
            self.exitButton.heightAnchor.constraint(equalToConstant: 60),
            
            self.outerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.outerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.outerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            self.outerView.heightAnchor.constraint(equalToConstant: 70),
            
            self.searchImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.searchImageView.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 20),
            self.searchImageView.widthAnchor.constraint(equalToConstant: 15),
            self.searchImageView.heightAnchor.constraint(equalToConstant: 15),
            
            self.keywordTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.keywordTextField.leadingAnchor.constraint(equalTo: self.searchImageView.trailingAnchor, constant: 10),
            self.keywordTextField.heightAnchor.constraint(equalToConstant: 30),
            self.keywordTextField.trailingAnchor.constraint(equalTo: self.searchButton.leadingAnchor, constant: -15),
            
            self.searchButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.searchButton.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -20),
            self.searchButton.heightAnchor.constraint(equalToConstant: 30),
            self.searchButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func searchButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.searchButtonCommand(self.keywordTextField.text!)
        })
    }
    
    @objc func exitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.exitButtonCommand()
        })
    }
    
}
