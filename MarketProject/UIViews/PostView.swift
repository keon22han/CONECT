//
//  PostView.swift
//  MarketProject
//
//  Created by 한건희 on 9/2/24.
//

import Foundation
import UIKit

class PostView: UIView {
    let post: Post
    
    let outerView = UIView()
    
    let postImageView = UIImageView()
    let postTitleLabel = UILabel()
    
    let authorImageView = UIImageView()
    let authorLabel = UILabel()
    let postDateLabel = UILabel()
    let priceLabel = UILabel()
    
    let isOnSaleImageView = UIImageView()
    let isOnSaleLabel = UILabel()
    
    init(post: Post) {
        self.post = post
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.backgroundColor = .white
        self.outerView.layer.cornerRadius = 15
        self.outerView.layer.shadowColor = UIColor.black.cgColor
        self.outerView.layer.shadowOpacity = 0.5
        self.outerView.layer.shadowRadius = 3
        self.outerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.outerView.layer.masksToBounds = false
        self.addSubview(self.outerView)
        
        self.postImageView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.addSubview(self.postImageView)
        
        self.postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.postTitleLabel.text = post.postTitle
        self.postTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        self.postTitleLabel.textColor = .black
        self.postTitleLabel.textAlignment = .left
        self.postTitleLabel.numberOfLines = 1
        self.outerView.addSubview(self.postTitleLabel)
        
        DBManager.instance.getUserInformation(userDBId: post.authorDBId, completion: { success, user in
            self.authorLabel.text = user?.nickName
        })
        
        self.authorImageView.translatesAutoresizingMaskIntoConstraints = false
        self.authorImageView.image = UIImage(named: "user-default")
        self.outerView.addSubview(self.authorImageView)
        
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.authorLabel.textColor = .black
        self.authorLabel.textAlignment = .right
        self.authorLabel.numberOfLines = -1
        self.outerView.addSubview(self.authorLabel)
        
        self.postDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.postDateLabel.text = post.postDate
        self.postDateLabel.textColor = .black
        self.postDateLabel.textAlignment = .left
        self.postDateLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
        self.outerView.addSubview(self.postDateLabel)
        
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.text = "\(post.productPrice) 원"
        self.priceLabel.textColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.priceLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        self.priceLabel.textAlignment = .left
        self.outerView.addSubview(self.priceLabel)
        
        self.isOnSaleImageView.translatesAutoresizingMaskIntoConstraints = false
        self.isOnSaleImageView.image = post.isOnSale ? UIImage(named: "green-circle")?.resized(to: CGSize(width: 10, height: 10)) : UIImage(named: "red-circle")?.resized(to: CGSize(width: 10, height: 10))
        self.outerView.addSubview(self.isOnSaleImageView)
        
        self.isOnSaleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.isOnSaleLabel.text = post.isOnSale ? "판매중" : "판매 완료"
        self.isOnSaleLabel.textColor = post.isOnSale ? UIColor.black : UIColor.gray
        self.isOnSaleLabel.textAlignment = .left
        self.isOnSaleLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.outerView.addSubview(self.isOnSaleLabel)
        
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 120),
            
            self.outerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.outerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.outerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.outerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.postImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            self.postImageView.widthAnchor.constraint(equalTo: self.postImageView.heightAnchor),
            self.postImageView.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 10),
            self.postImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.postTitleLabel.topAnchor.constraint(equalTo: self.postImageView.topAnchor),
            self.postTitleLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -10),
            self.postTitleLabel.leadingAnchor.constraint(equalTo: self.postImageView.trailingAnchor, constant: 20),
            
            self.postDateLabel.topAnchor.constraint(equalTo: self.postTitleLabel.bottomAnchor, constant: 5),
            self.postDateLabel.leadingAnchor.constraint(equalTo: self.postTitleLabel.leadingAnchor),
            self.postDateLabel.trailingAnchor.constraint(equalTo: self.postTitleLabel.trailingAnchor),
            
            self.authorImageView.widthAnchor.constraint(equalToConstant: 20),
            self.authorImageView.heightAnchor.constraint(equalToConstant: 20),
            self.authorImageView.trailingAnchor.constraint(equalTo: self.authorLabel.leadingAnchor, constant: -10),
            self.authorImageView.centerYAnchor.constraint(equalTo: self.authorLabel.centerYAnchor),
            
            self.authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -15),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.postDateLabel.bottomAnchor, constant: 5),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.postTitleLabel.leadingAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor),
            
            self.isOnSaleImageView.centerYAnchor.constraint(equalTo: self.authorLabel.centerYAnchor),
            self.isOnSaleImageView.leadingAnchor.constraint(equalTo: self.postTitleLabel.leadingAnchor),
            self.isOnSaleImageView.widthAnchor.constraint(equalToConstant: 10),
            self.isOnSaleImageView.heightAnchor.constraint(equalToConstant: 10),
            
            self.isOnSaleLabel.centerYAnchor.constraint(equalTo: self.isOnSaleImageView.centerYAnchor),
            self.isOnSaleLabel.leadingAnchor.constraint(equalTo: self.isOnSaleImageView.trailingAnchor, constant: 5),
            
        ])
    }
    
    public func setPostImage(postImage: UIImage) {
        DispatchQueue.main.async {
            self.postImageView.image = postImage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
