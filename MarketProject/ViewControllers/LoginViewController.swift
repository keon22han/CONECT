//
//  LoginViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/23/24.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.logoImageView.startBouncing()
        
        setupKeyboardNotification()
        
        self.idTextField.delegate = self
        self.pwTextField.delegate = self
        
        self.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loginButtonClicked(_ sender: UIButton) {
        
        // TODO: Test Code (24.08.31 : 냉장고 데이터 추가 필요한 경우 해당 코드 사용)
        // CreateRefrigeratorFoodSample.instance.createSampleData()
        
        // TODO: id, pw validation 추가 (24.08.29)
        // isIdPasswordValid()
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.present(loadingViewController, animated: true)
        
        DBManager.instance.signIn(email: self.idTextField.text!, password: self.pwTextField.text!) { success, errorMessage in
            
            if success {
                loadingViewController.dismiss(animated: true)
                let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarController")
                self.navigationController?.pushViewController(tabBarViewController!, animated: true)
            }
            
            else {
                let loginFailViewController = UIViewController()
                loginFailViewController.modalPresentationStyle = .overFullScreen
                loginFailViewController.modalTransitionStyle = .crossDissolve
                loginFailViewController.view.backgroundColor = .clear
                
                let loginFailView = UIView()
                loginFailView.translatesAutoresizingMaskIntoConstraints = false
                loginFailView.backgroundColor = .white
                loginFailView.layer.cornerRadius = 10
                loginFailView.layer.masksToBounds = true
                loginFailViewController.view.addSubview(loginFailView)
                
                let loginFailLabel = UILabel()
                loginFailLabel.translatesAutoresizingMaskIntoConstraints = false
                loginFailLabel.text = "로그인 실패"
                loginFailLabel.textColor = .darkGray
                loginFailLabel.textAlignment = .center
                loginFailLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
                loginFailView.addSubview(loginFailLabel)
                
                NSLayoutConstraint.activate([
                    loginFailLabel.centerXAnchor.constraint(equalTo: loginFailView.centerXAnchor),
                    loginFailLabel.centerYAnchor.constraint(equalTo: loginFailView.centerYAnchor),
                    
                    loginFailView.centerYAnchor.constraint(equalTo: loginFailViewController.view.centerYAnchor),
                    loginFailView.leadingAnchor.constraint(equalTo: loginFailViewController.view.leadingAnchor, constant: 80),
                    loginFailView.trailingAnchor.constraint(equalTo: loginFailViewController.view.trailingAnchor, constant: -80),
                    loginFailView.heightAnchor.constraint(equalToConstant: 100),
                ])
                
                loadingViewController.dismiss(animated: true, completion: {
                    self.present(loginFailViewController, animated: true)
                })
                
                Task {
                    do {
                        try await Task.sleep(nanoseconds: 1000000000)
                        loginFailViewController.dismiss(animated: true)
                    } catch {
                        return
                    }
                }
            }
        }
    }
    
    
    
    
    @objc func registerButtonClicked(_ sender: UIButton) {
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController")
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }
}
