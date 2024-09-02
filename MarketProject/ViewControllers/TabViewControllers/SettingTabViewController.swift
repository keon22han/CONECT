

import UIKit

class SettingTabViewController: UIViewController {

    let logoutButton = UIButton()
    let userInformationView = UIView()
    let userImageView = UIImageView()
    let userNickNameLabel = UILabel()
    
    // 테이블 예약 현황 확인 뷰 (전체)
    let userReservationStateView = UIView()
    let userReservationStateViewLabel = UILabel() // "현재 고객님의 예약 현황입니다"
    
    // 과거, 미래 예약 Scroll View
    let userPastReservationScrollView = UIScrollView()
    let userFutureReservationScrollView = UIScrollView()
    
    // Scroll View 내부 UIView
    let userPastReservationView = UIView()
    let userFutureReservationView = UIView()
    
    // UIView에 부착할 Stack View , 실제 예약 현황(뷰 생성) 불러와 해당 StackView에 추가
    let userPastReservationStackView = UIStackView()
    let userFutureReservationStackView = UIStackView()
    
    // 장바구니 QR 안내 Label
    let getShoppingCartQRInfoLabel = UILabel()
    // 장바구니 QR 버튼
    let getShoppingCartQRButton = UIButton()
    
    
    // 추후 유저 정보 UIView 아래 항목들 추가할 예정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.contentMode = .redraw
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let buttonConfiguration = UIButton.Configuration.plain()
        self.logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.logoutButton.configuration = buttonConfiguration
        self.logoutButton.configuration?.imagePlacement = .top
        self.logoutButton.configuration?.imagePadding = 5
        self.logoutButton.setTitle("로그아웃", for: .normal)
        self.logoutButton.setTitleColor(.black, for: .normal)
        self.logoutButton.setImage(UIImage(named: "exit-unselected")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.logoutButton.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.logoutButton)
        
        self.userInformationView.translatesAutoresizingMaskIntoConstraints = false
        self.userInformationView.layer.cornerRadius = 10
        self.userInformationView.layer.masksToBounds = true
        self.userInformationView.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 0.3)
        self.view.addSubview(self.userInformationView)
        
        self.userImageView.translatesAutoresizingMaskIntoConstraints = false
        self.userImageView.layer.cornerRadius = 10
        self.userImageView.layer.masksToBounds = true
        self.userImageView.image = UIImage(named: "user-default")
        self.userInformationView.addSubview(self.userImageView)
        
        
        self.userNickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userNickNameLabel.text = ""
        self.userNickNameLabel.textAlignment = .left
        self.userNickNameLabel.textColor = .black
        self.userNickNameLabel.font = UIFont(name: "Pretendard-Medium", size: 20)
        self.userInformationView.addSubview(self.userNickNameLabel)
        
        // Fetch user information
        DBManager.instance.getUserInformation(userDBId: DBManager.instance.getUserId()) { success, userInfo in
            if success {
                self.userNickNameLabel.text = userInfo?.nickName
            }
        }
        
        self.userReservationStateView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.userReservationStateView)
        
        self.userReservationStateViewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userReservationStateViewLabel.text = "현재 회원님의 예약 현황입니다."
        self.userReservationStateViewLabel.textAlignment = .center
        self.userReservationStateViewLabel.textColor = .black
        self.userReservationStateViewLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.userReservationStateView.addSubview(self.userReservationStateViewLabel)
        
        self.userPastReservationScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.userPastReservationScrollView.layer.cornerRadius = 5
        self.userPastReservationScrollView.layer.masksToBounds = true
        self.userPastReservationScrollView.showsVerticalScrollIndicator = false
        self.userReservationStateView.addSubview(self.userPastReservationScrollView)
        
        self.userFutureReservationScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.userFutureReservationScrollView.layer.cornerRadius = 5
        self.userFutureReservationScrollView.layer.masksToBounds = true
        self.userFutureReservationScrollView.showsVerticalScrollIndicator = false
        self.userReservationStateView.addSubview(self.userFutureReservationScrollView)
        
        self.userPastReservationView.translatesAutoresizingMaskIntoConstraints = false
        
        self.userFutureReservationView.translatesAutoresizingMaskIntoConstraints = false
        
        self.userPastReservationStackView.translatesAutoresizingMaskIntoConstraints = false
        self.userPastReservationStackView.axis = .vertical
        self.userPastReservationStackView.alignment = .center
        self.userPastReservationStackView.distribution = .equalSpacing
        self.userPastReservationStackView.spacing = 10
        self.userPastReservationScrollView.addSubview(self.userPastReservationStackView)
        
        self.userFutureReservationStackView.translatesAutoresizingMaskIntoConstraints = false
        self.userFutureReservationStackView.axis = .vertical
        self.userFutureReservationStackView.alignment = .center
        self.userFutureReservationStackView.distribution = .equalSpacing
        self.userFutureReservationStackView.spacing = 10
        self.userFutureReservationStackView.alignment = .center
        self.userFutureReservationScrollView.addSubview(self.userFutureReservationStackView)
        
        self.setReservationInformation()
        
        self.getShoppingCartQRButton.translatesAutoresizingMaskIntoConstraints = false
        self.getShoppingCartQRButton.setImage(UIImage(named: "qr-code")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.getShoppingCartQRButton.addTarget(self, action: #selector(getShoppingCartQRButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.getShoppingCartQRButton)
        
        self.getShoppingCartQRInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.getShoppingCartQRInfoLabel.text = "우측의 QR 이미지를 눌러 장바구니 QR 인식 후 대여가 가능합니다."
        self.getShoppingCartQRInfoLabel.textAlignment = .right
        self.getShoppingCartQRInfoLabel.textColor = .black
        self.getShoppingCartQRInfoLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.view.addSubview(self.getShoppingCartQRInfoLabel)
        
        
        
        NSLayoutConstraint.activate([
            self.logoutButton.centerYAnchor.constraint(equalTo: self.userInformationView.centerYAnchor),
            self.logoutButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.logoutButton.widthAnchor.constraint(equalToConstant: 100),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.userInformationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.userInformationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.userInformationView.trailingAnchor.constraint(equalTo: self.logoutButton.leadingAnchor, constant: -10),
            self.userInformationView.heightAnchor.constraint(equalToConstant: 70),
            self.userImageView.centerYAnchor.constraint(equalTo: self.userInformationView.centerYAnchor),
            self.userImageView.leadingAnchor.constraint(equalTo: self.userInformationView.leadingAnchor, constant: 15),
            self.userImageView.widthAnchor.constraint(equalToConstant: 50),
            self.userImageView.heightAnchor.constraint(equalToConstant: 50),
            self.userNickNameLabel.centerYAnchor.constraint(equalTo: self.userImageView.centerYAnchor),
            self.userNickNameLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 20),
            
            self.userReservationStateView.topAnchor.constraint(equalTo: self.userInformationView.bottomAnchor, constant: 20),
            self.userReservationStateView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.userReservationStateView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.userReservationStateView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            
            self.userReservationStateViewLabel.topAnchor.constraint(equalTo: self.userReservationStateView.topAnchor, constant: 10),
            self.userReservationStateViewLabel.leadingAnchor.constraint(equalTo: self.userReservationStateView.leadingAnchor, constant: 10),
            self.userReservationStateViewLabel.trailingAnchor.constraint(equalTo: self.userReservationStateView.trailingAnchor, constant: -10),
            
            self.userPastReservationScrollView.topAnchor.constraint(equalTo: self.userReservationStateViewLabel.bottomAnchor, constant: 20),
            self.userPastReservationScrollView.leadingAnchor.constraint(equalTo: self.userReservationStateView.leadingAnchor, constant: 10),
            self.userPastReservationScrollView.trailingAnchor.constraint(equalTo: self.userReservationStateView.centerXAnchor, constant: -10),
            self.userPastReservationScrollView.bottomAnchor.constraint(equalTo: self.userReservationStateView.bottomAnchor, constant: -10),
            
            self.userFutureReservationScrollView.topAnchor.constraint(equalTo: self.userReservationStateViewLabel.bottomAnchor, constant: 20),
            self.userFutureReservationScrollView.leadingAnchor.constraint(equalTo: self.userReservationStateView.centerXAnchor, constant: 10),
            self.userFutureReservationScrollView.trailingAnchor.constraint(equalTo: self.userReservationStateView.trailingAnchor, constant: -10),
            self.userFutureReservationScrollView.bottomAnchor.constraint(equalTo: self.userReservationStateView.bottomAnchor, constant: -10),
            
            self.userPastReservationStackView.topAnchor.constraint(equalTo: self.userPastReservationScrollView.contentLayoutGuide.topAnchor),
            self.userPastReservationStackView.widthAnchor.constraint(equalTo: self.userPastReservationScrollView.widthAnchor),
            self.userPastReservationStackView.bottomAnchor.constraint(equalTo: self.userPastReservationScrollView.contentLayoutGuide.bottomAnchor),
            
            self.userFutureReservationStackView.topAnchor.constraint(equalTo: self.userFutureReservationScrollView.contentLayoutGuide.topAnchor),
            self.userFutureReservationStackView.widthAnchor.constraint(equalTo: self.userFutureReservationScrollView.widthAnchor),
            self.userFutureReservationStackView.bottomAnchor.constraint(equalTo: self.userFutureReservationScrollView.contentLayoutGuide.bottomAnchor),
            self.getShoppingCartQRButton.topAnchor.constraint(equalTo: self.userReservationStateView.bottomAnchor, constant: 15),
            self.getShoppingCartQRButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.getShoppingCartQRButton.widthAnchor.constraint(equalToConstant: 40),
            self.getShoppingCartQRButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.getShoppingCartQRInfoLabel.centerYAnchor.constraint(equalTo: self.getShoppingCartQRButton.centerYAnchor),
            self.getShoppingCartQRInfoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.getShoppingCartQRInfoLabel.trailingAnchor.constraint(equalTo: self.getShoppingCartQRButton.leadingAnchor, constant: -10)
        ])
    }
    
    
    func getUserReservationInformation(completion: @escaping(() -> Void)) {
        DBManager.instance.getUserReservationData(userDBId: DBManager.instance.getUserId()) { success, reservationInfos in
            
            if !success {
                // TODO: 예약 현황 없음 표시
                completion()
                return
            }
            
            var pastReservationInfos = [ShareTableReservationInfo]()
            var futureReservationInfos = [ShareTableReservationInfo]()
            
            for reservationInfo in reservationInfos! {
                
                let reserveDateString = "\(reservationInfo.date!) \(reservationInfo.time!)"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let reserveDate = dateFormatter.date(from: reserveDateString)
                let now = Date()
                
                switch reserveDate!.compare(now) {
                case .orderedSame :
                    print("same time!")
                case .orderedAscending: // 과거 예약 정보
                    pastReservationInfos.append(reservationInfo)
                case .orderedDescending: // 미래 예약 정보
                    futureReservationInfos.append(reservationInfo)
                }
            }
            
            self.sortReservationsByDate(reservations: &pastReservationInfos)
            self.sortReservationsByDate(reservations: &futureReservationInfos)
            
            self.setUserReservationInfoUI(isAvailable: false, reservationInfos: pastReservationInfos)
            self.setUserReservationInfoUI(isAvailable: true, reservationInfos: futureReservationInfos)
            
            completion()
        }
    }
    
    func convertToDate(date: String, time: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateTimeString = "\(date) \(time)"
        return dateFormatter.date(from: dateTimeString)
    }

    // 날짜 기준 정렬
    func sortReservationsByDate(reservations: inout [ShareTableReservationInfo]) {
        reservations.sort { (first, second) -> Bool in
            guard let firstDate = convertToDate(date: first.date ?? "", time: first.time ?? ""),
                  let secondDate = convertToDate(date: second.date ?? "", time: second.time ?? "") else {
                return false
            }
            
            return firstDate > secondDate
        }
    }
    
    func setReservationInformation() {
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.navigationController!.present(loadingViewController, animated: true)
        print(loadingViewController.isBeingPresented)
        
        for view in self.userPastReservationStackView.arrangedSubviews {
            self.userPastReservationStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for view in self.userFutureReservationStackView.arrangedSubviews {
            self.userFutureReservationStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        
        self.getUserReservationInformation(completion: {
            DispatchQueue.main.async {
                loadingViewController.dismiss(animated: true)
            }
        })
    }
    
    func setUserReservationInfoUI(isAvailable: Bool, reservationInfos: [ShareTableReservationInfo]) {
        
        for reservationInfo in reservationInfos {
            // TODO: View 생성
            let smallReservationInformationView = SmallReservationInformationView(isAvailable: isAvailable, shareTableReservationInfo: reservationInfo)
            smallReservationInformationView.translatesAutoresizingMaskIntoConstraints = false
            if isAvailable {
                self.userFutureReservationStackView.addArrangedSubview(smallReservationInformationView)
            } else {
                self.userPastReservationStackView.addArrangedSubview(smallReservationInformationView)
            }
            
            NSLayoutConstraint.activate([
                smallReservationInformationView.heightAnchor.constraint(equalToConstant: 70),
                smallReservationInformationView.widthAnchor.constraint(equalTo: self.userPastReservationStackView.widthAnchor, constant: -10)
            ])
        }
        
            
    }
    
    @objc func logoutButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func getShoppingCartQRButtonClicked(_ sender: UIButton) {
        AnimationHelper.instance.startViewSpringAnimation(view: self.getShoppingCartQRButton, duration: 0.5, scale: 1.1)
        PermissionManager.instance.requestCameraPermission(parentViewController: self, completion: { allowed in
            if allowed {
                DispatchQueue.main.async {
                    let qrCodeScannerViewController = QRCodeScannerViewController()
                    self.present(qrCodeScannerViewController, animated: true)
                }
            } else {
            }
        })
    }
}
