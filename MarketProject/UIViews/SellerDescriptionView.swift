//
//  SellerDescriptionView.swift
//  MarketProject
//
//  Created by 한건희 on 8/10/24.
//

import UIKit

class SellerDescriptionView : UIView {
    
    let uiStackView = UIStackView()
    let sellerImageView = UIImageView()
    let marketDescriptionLabel = UILabel()
    let sellerDescriptionLabel = UILabel()
    var sellerDetailDescriptionText = String()
    
    let tabGestureRecognizer = UITapGestureRecognizer() // tab gesture
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        self.sellerImageView.layer.shadowColor = UIColor.black.cgColor
        self.sellerImageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.sellerImageView.layer.masksToBounds = true
        self.sellerImageView.contentMode = .scaleAspectFill
        self.sellerImageView.layer.cornerRadius = 20
        self.sellerImageView.layer.shadowRadius = 5
        self.sellerImageView.layer.shadowOpacity = 0.5
        
        self.tabGestureRecognizer.addTarget(self, action: #selector(isTapped))
        addGestureRecognizer(self.tabGestureRecognizer)
        
        self.uiStackView.translatesAutoresizingMaskIntoConstraints = false
        self.uiStackView.distribution = .equalSpacing
        self.uiStackView.alignment = .top
        self.uiStackView.spacing = 3
        self.uiStackView.axis = .vertical
        self.addSubview(self.uiStackView)
        
        self.sellerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.sellerImageView.image = UIImage(named: "store-default1")
        self.sellerImageView.contentMode = .scaleAspectFill
        self.sellerImageView.layer.cornerRadius = 10
        self.uiStackView.addArrangedSubview(self.sellerImageView)
        
        self.marketDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.marketDescriptionLabel.text = "default"
        self.marketDescriptionLabel.numberOfLines = -1
        self.marketDescriptionLabel.textColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.marketDescriptionLabel.font = UIFont(name: "Pretendard-Medium", size: 18)
        self.uiStackView.addArrangedSubview(self.marketDescriptionLabel)
        
        self.sellerDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sellerDescriptionLabel.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.sellerDescriptionLabel.text = "default"
        self.sellerDescriptionLabel.numberOfLines = -1
        self.uiStackView.addArrangedSubview(self.sellerDescriptionLabel)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 350),
            self.sellerImageView.heightAnchor.constraint(equalToConstant: 250),
            self.uiStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.uiStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.uiStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.uiStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
    
    public func SetUpSellerDescription(imagePath: String, marketDescription: String, sellerDescription: String, sellerDetailDescription: String) {
        DBManager.instance.downloadImageFromDB(imageURL: imagePath, completion: { storeImage in
            if storeImage == nil {
                self.sellerImageView.image = UIImage(named: "store-default")
            } else {
                self.sellerImageView.image = storeImage
            }
        })
        
        self.marketDescriptionLabel.text = marketDescription
        self.sellerDescriptionLabel.text = sellerDescription
        self.sellerDetailDescriptionText = sellerDetailDescription
    }
    
    @objc func isTapped(_ sender: UITapGestureRecognizer) {
        if let superViewController = self.findViewController() {
            let storeDetailViewController = StoreDetailViewController(detailText: self.sellerDetailDescriptionText)
            storeDetailViewController.modalPresentationStyle = .overFullScreen
            storeDetailViewController.modalTransitionStyle = .crossDissolve
            superViewController.present(storeDetailViewController, animated: true)
        }
    }
}
