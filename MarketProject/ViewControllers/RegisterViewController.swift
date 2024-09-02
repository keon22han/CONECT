//
//  RegisterViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/23/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var finishRegistrationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardNotification()
        
        self.previousButton.addTarget(self, action: #selector(previousButtonClicked), for: .touchUpInside)
        
        self.finishRegistrationButton.addTarget(self, action: #selector(finishRegistrationButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func previousButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func finishRegistrationButtonClicked(_ sender: UIButton) {
        
        // TODO: id, pw validation 추가
        // isIdPasswordValid()
        
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.present(loadingViewController, animated: true)
        
        DBManager.instance.signUp(email: self.idTextField.text!, password: self.pwTextField.text!) { signupResult, error in
            
            if error != nil {
                let signupFailViewController = UIViewController()
                signupFailViewController.modalPresentationStyle = .overFullScreen
                signupFailViewController.modalTransitionStyle = .crossDissolve
                signupFailViewController.view.backgroundColor = .clear
                
                let signupFailView = UIView()
                signupFailView.translatesAutoresizingMaskIntoConstraints = false
                signupFailView.backgroundColor = .white
                signupFailView.layer.cornerRadius = 10
                signupFailView.layer.masksToBounds = true
                signupFailViewController.view.addSubview(signupFailView)
                
                let signupFailLabel = UILabel()
                signupFailLabel.translatesAutoresizingMaskIntoConstraints = false
                signupFailLabel.text = "회원가입 실패"
                signupFailLabel.textColor = .darkGray
                signupFailLabel.textAlignment = .center
                signupFailLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
                signupFailView.addSubview(signupFailLabel)
                
                NSLayoutConstraint.activate([
                    signupFailLabel.centerXAnchor.constraint(equalTo: signupFailView.centerXAnchor),
                    signupFailLabel.centerYAnchor.constraint(equalTo: signupFailView.centerYAnchor),
                    
                    signupFailView.centerYAnchor.constraint(equalTo: signupFailViewController.view.centerYAnchor),
                    signupFailView.leadingAnchor.constraint(equalTo: signupFailViewController.view.leadingAnchor, constant: 80),
                    signupFailView.trailingAnchor.constraint(equalTo: signupFailViewController.view.trailingAnchor, constant: -80),
                    signupFailView.heightAnchor.constraint(equalToConstant: 100),
                ])
                
                loadingViewController.dismiss(animated: true, completion: {
                    self.present(signupFailViewController, animated: true)
                })
                
                Task {
                    do {
                        try await Task.sleep(nanoseconds: 1000000000)
                        signupFailViewController.dismiss(animated: true)
                    } catch {
                        return
                    }
                }
            }
            
            if signupResult == true {
                let userInfo = User(userDBId: DBManager.instance.getUserId(), nickName: self.nickNameTextField.text!, userEmail: self.idTextField.text!, userPassword: self.pwTextField.text!)
                
                DBManager.instance.uploadUserData(userInfo: userInfo)
                
                loadingViewController.dismiss(animated: true, completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
        
    }
}
