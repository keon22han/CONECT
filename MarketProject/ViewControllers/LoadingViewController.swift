//
//  LoadingViewController.swift
//  MarketProject
//
//  Created by 한건희 on 9/1/24.
//

import UIKit

class LoadingViewController: UIViewController {

    let loadingImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.4)
        self.loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        self.loadingImageView.image = UIImage(named: "loading-image")
        self.view.addSubview(self.loadingImageView)
        
        NSLayoutConstraint.activate([
            self.loadingImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.loadingImageView.widthAnchor.constraint(equalToConstant: 50),
            self.loadingImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        AnimationHelper.instance.startViewSpringAnimationRepeat(view: self.loadingImageView, duration: 0.8, scale: 1.1)
    }
}
