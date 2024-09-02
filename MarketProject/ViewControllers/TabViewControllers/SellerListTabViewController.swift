//
//  SellerListTabViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/9/24.
//

import UIKit
import DropDown

class SellerListTabViewController: UIViewController {

    let topSelectionDropDown = DropDown()
    let topSelectionButton = UIButton()
    
    var storesData = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 현재는 스토어 임의 생성 (2024-08-28)
        
        
        
        let store1 = Store(storeImageUrl: "", storeName: "건희스토어", storeDescription: "건희스토어입니다", storeDetailDescription: "자세한정보입니다")
        DBManager.instance.uploadStoreData(storeData: store1)
        
        let store2 = Store(storeImageUrl: "", storeName: "강희스토어", storeDescription: "강희스토어입니다", storeDetailDescription: "자세한정보입니다")
        DBManager.instance.uploadStoreData(storeData: store2)
        
        DBManager.instance.getAllStoreData(completion: { isExist, stores in
            if !isExist {
                print("stores doesn't exist!")
            }
            
            self.storesData = stores!
            self.SetupView()
        })
    }
    
    private func SetupView() {
        
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "application-background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0
        self.view.addSubview(backgroundImageView)
        
        let topUiStackView = UIStackView()
        topUiStackView.translatesAutoresizingMaskIntoConstraints = false
        topUiStackView.axis = .horizontal
        topUiStackView.backgroundColor = .clear
        topUiStackView.distribution = .equalCentering
        topUiStackView.alignment = .center
        self.view.addSubview(topUiStackView)
        
        // -------- top bar left --------
        
        let topBarLeftStackView = UIStackView()
        topBarLeftStackView.translatesAutoresizingMaskIntoConstraints = false
        topBarLeftStackView.backgroundColor = UIColor.lightGray
        topBarLeftStackView.axis = .horizontal
        topBarLeftStackView.backgroundColor = .clear
        topBarLeftStackView.distribution =  .fillEqually
        topBarLeftStackView.alignment = .leading
        topUiStackView.addArrangedSubview(topBarLeftStackView)
        
        let buttonConfiguration = UIButton.Configuration.plain()
        self.topSelectionButton.configuration = buttonConfiguration
        self.topSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        self.topSelectionButton.contentHorizontalAlignment = .center
        self.topSelectionButton.titleLabel?.adjustsFontForContentSizeCategory = true
        self.topSelectionButton.setImage(UIImage(named: "dropdown")?.resized(to: CGSize(width: 15, height: 15)), for: .normal)
        self.topSelectionButton.tintColor = .secondaryLabel
        self.topSelectionButton.setTitle("수산물", for: .normal)
        self.topSelectionButton.setTitleColor(.black, for: .normal)
        self.topSelectionButton.configuration?.imagePlacement = .trailing
        self.topSelectionButton.contentVerticalAlignment = .center
        self.topSelectionButton.contentHorizontalAlignment = .leading
        self.topSelectionButton.configuration?.imagePadding = 10
        self.topSelectionButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        topBarLeftStackView.addArrangedSubview(self.topSelectionButton)
        
        let itemList = ["수산물", "해산물", "농작물"]
        
        self.topSelectionDropDown.backgroundColor = UIColor.lightGray
        self.topSelectionDropDown.dataSource = itemList
        self.topSelectionDropDown.anchorView = topSelectionButton
        self.topSelectionDropDown.bottomOffset = CGPoint(x: 0, y: 30)
        DropDown.appearance().textColor = UIColor.black //item text color
        DropDown.appearance().selectedTextColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cornerRadius = 10
        
        // select 시 동작
        self.topSelectionDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            (self.topSelectionDropDown.anchorView as! UIButton).setTitle(item, for: .normal)
            (self.topSelectionDropDown.anchorView as! UIButton).setImage(UIImage(named: "dropdown")?.resized(to: CGSize(width: 15, height: 15)), for: .normal)
        }
        
        // DropDown 오픈 상태에서 DropDown 이외 영역 터치 시 동작
        self.topSelectionDropDown.cancelAction = { [unowned self] in
            self.topSelectionButton.setImage(UIImage(named: "dropdown")?.resized(to: CGSize(width: 15, height: 15)), for: .normal)
        }
        
        
        // -------- top bar right --------
        
        let topBarRightStackView = UIStackView()
        topBarRightStackView.translatesAutoresizingMaskIntoConstraints = false
        topBarRightStackView.axis = .horizontal
        topBarRightStackView.backgroundColor = .clear
        topBarRightStackView.spacing = 10
        topBarRightStackView.alignment = .trailing
        topUiStackView.addArrangedSubview(topBarRightStackView)
        
        let topMenuLabel1 = UILabel()
        topMenuLabel1.translatesAutoresizingMaskIntoConstraints = false
        topMenuLabel1.textColor = .black
        topMenuLabel1.text = "="
        topBarRightStackView.addArrangedSubview(topMenuLabel1)
        
        let topMenuLabel2 = UILabel()
        topMenuLabel2.translatesAutoresizingMaskIntoConstraints = false
        topMenuLabel2.textColor = .black
        topMenuLabel2.text = "+"
        topBarRightStackView.addArrangedSubview(topMenuLabel2)
        
        let topMenuLabel3 = UILabel()
        topMenuLabel3.translatesAutoresizingMaskIntoConstraints = false
        topMenuLabel3.textColor = .black
        topMenuLabel3.text = "M"
        topBarRightStackView.addArrangedSubview(topMenuLabel3)
        
        
        // --------------------------------
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            topUiStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            topUiStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topUiStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topUiStackView.heightAnchor.constraint(equalToConstant: 60),
            topBarLeftStackView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // ----------상인 소개 라벨-----------
        
        let topSellerLabel = UILabel()
        topSellerLabel.translatesAutoresizingMaskIntoConstraints = false
        topSellerLabel.text = "상점 목록"
        topSellerLabel.textColor = .black
        topSellerLabel.textAlignment = .left
        topSellerLabel.font = UIFont(name: "Pretendard-Bold", size: 25)
        stackView.addArrangedSubview(topSellerLabel)
        
        
        for storeData in self.storesData {
            let storeDescriptionView = SellerDescriptionView()
            storeDescriptionView.SetUpSellerDescription(imagePath: storeData.storeImageUrl, marketDescription: storeData.storeName, sellerDescription: storeData.storeDescription, sellerDetailDescription: storeData.storeDetailDescription)
            stackView.addArrangedSubview(storeDescriptionView)
        }
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topUiStackView.bottomAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            topSellerLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            topSellerLabel.leadingAnchor.constraint(equalTo: topUiStackView.leadingAnchor),
            topSellerLabel.trailingAnchor.constraint(equalTo: topUiStackView.trailingAnchor),
            topSellerLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    @objc func buttonClicked()
    {
        if topSelectionDropDown.isHidden {
            self.topSelectionDropDown.show()
            self.topSelectionButton.setImage(UIImage(named: "dropup")?.resized(to: CGSize(width: 15, height: 15)), for: .normal)
        }
    }
}

