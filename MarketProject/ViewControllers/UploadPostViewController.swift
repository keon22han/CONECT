//
//  UploadPostViewController.swift
//  MarketProject
//
//  Created by 한건희 on 9/2/24.
//

import UIKit
import PhotosUI

class UploadPostViewController: UIViewController, PHPickerViewControllerDelegate {
    

    let exitButton = UIButton()
    let uploadButton = UIButton()
    let postImageView = UIImageView()
    let postTitleTextField = UITextField()
    let postContentTextView = UITextView()
    let productPriceTextField = UITextField()
    let productTypeSelectButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupKeyboardNotification()
        
        self.view.backgroundColor = .white
        
        self.exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.uploadButton.translatesAutoresizingMaskIntoConstraints = false
        self.postImageView.translatesAutoresizingMaskIntoConstraints = false
        self.postTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.postContentTextView.translatesAutoresizingMaskIntoConstraints = false
        self.productPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        self.productTypeSelectButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.exitButton.setImage(UIImage(named: "exit")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.exitButton)
        
        self.uploadButton.setImage(UIImage(named: "check")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.uploadButton.addTarget(self, action: #selector(uploadButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.uploadButton)
        
        self.postImageView.image = UIImage(named: "store-default")
        self.postImageView.contentMode = .scaleAspectFit
        self.postImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(postImageViewTapped))
        self.postImageView.addGestureRecognizer(tapGestureRecognizer)
        self.view.addSubview(self.postImageView)
        
        self.postTitleTextField.placeholder = "  게시글 제목을 작성해주세요."
        self.postTitleTextField.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.postTitleTextField.borderStyle = .roundedRect
        self.view.addSubview(self.postTitleTextField)
        
        self.postContentTextView.isEditable = true
        self.postContentTextView.isScrollEnabled = true
        self.postContentTextView.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.postContentTextView.layer.borderWidth = 0.5
        self.postContentTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        self.postContentTextView.layer.cornerRadius = 5
        self.view.addSubview(self.postContentTextView)

        self.productPriceTextField.placeholder = "  가격을 입력해주세요"
        self.productPriceTextField.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.productPriceTextField.borderStyle = .roundedRect
        self.view.addSubview(self.productPriceTextField)
        
        self.productTypeSelectButton.setTitle("제품군 선택", for: .normal)
        self.productTypeSelectButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.productTypeSelectButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.productTypeSelectButton.layer.cornerRadius = 10
        self.productTypeSelectButton.addTarget(self, action: #selector(productTypeSelectButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.productTypeSelectButton)
        
        NSLayoutConstraint.activate([
            self.exitButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.exitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.exitButton.widthAnchor.constraint(equalToConstant: 40),
            self.exitButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.uploadButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.uploadButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.uploadButton.widthAnchor.constraint(equalToConstant: 40),
            self.uploadButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.postImageView.topAnchor.constraint(equalTo: self.uploadButton.bottomAnchor, constant: 40),
            self.postImageView.centerXAnchor.constraint(equalTo:self.view.centerXAnchor),
            self.postImageView.widthAnchor.constraint(equalToConstant: 200),
            self.postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.productPriceTextField.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 30),
            self.productPriceTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.productPriceTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            self.productPriceTextField.heightAnchor.constraint(equalToConstant: 30),
            
            self.productTypeSelectButton.centerYAnchor.constraint(equalTo: self.productPriceTextField.centerYAnchor),
            self.productTypeSelectButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.productTypeSelectButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25),
            self.productTypeSelectButton.heightAnchor.constraint(equalToConstant: 30),
            
            self.postTitleTextField.topAnchor.constraint(equalTo: self.productPriceTextField.bottomAnchor, constant: 30),
            self.postTitleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.postTitleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.postTitleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            self.postContentTextView.topAnchor.constraint(equalTo: self.postTitleTextField.bottomAnchor, constant: 30),
            self.postContentTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.postContentTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.postContentTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
        ])
    }
    

    @objc func postImageViewTapped() {
        PermissionManager.instance.requestAlbumPermission(parentViewController: self, completion: { success in
            DispatchQueue.main.async {
                var config = PHPickerConfiguration()
                    config.selectionLimit = 1  // 선택할 수 있는 최대 사진 수 (0은 무제한)
                    config.filter = .images   // 필터를 이미지로 설정 (비디오로 설정할 수 있음)

                    let picker = PHPickerViewController(configuration: config)
                    picker.delegate = self  // PHPickerViewControllerDelegate 프로토콜을 채택한 현재 ViewController를 delegate로 설정
                    
                    self.present(picker, animated: true, completion: nil)
            }
        })
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.postImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    @objc func productTypeSelectButtonClicked(_ sender: UIButton) {
        
    }
    
    @objc func exitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func uploadButtonClicked(_ sender: UIButton) {
        
        // TODO: validation 추가 (2024.09.02)
        
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.present(loadingViewController, animated: true)
        
        let postDBId = UUID().uuidString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: Date())
        
        DBManager.instance.uploadImageToDB(image: self.postImageView.image!, completion: { imageUrl in
            let post = Post(postDBId: postDBId, authorDBId: DBManager.instance.getUserId(), postImageUrl: imageUrl!, postTitle: self.postTitleTextField.text!, postContent: self.postContentTextView.text!, productPrice: Int(self.productPriceTextField.text!)!, productType: "전자제품", postDate: dateString, isOnSale: true)
            
            DBManager.instance.uploadPostInfo(post: post)
            
            loadingViewController.dismiss(animated: true, completion: {
                self.dismiss(animated: true)
            })
        })
        
        
    }
}
