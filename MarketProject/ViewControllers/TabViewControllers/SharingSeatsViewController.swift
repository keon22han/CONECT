import Foundation
import UIKit

class SharingSeatsViewController: UIViewController {
    
    let backgroundImage = UIImageView(image: UIImage(named: "application-background"))
    
    let seatsView = UIView()
    
    let firstSeat = UIImageView(image: UIImage(named: "sharedtable-unselected")?.resized(to: CGSize(width: 50, height: 50)))
    let secondSeat = UIImageView(image: UIImage(named: "sharedtable-unselected")?.resized(to: CGSize(width: 50, height: 50)))
    let thirdSeat = UIImageView(image: UIImage(named: "sharedtable-unselected")?.resized(to: CGSize(width: 50, height: 50)))
    let fourthSeat = UIImageView(image: UIImage(named: "sharedtable-unselected")?.resized(to: CGSize(width: 50, height: 50)))
    
    let firstSeatLabel = UILabel()
    let secondSeatLabel = UILabel()
    let thirdSeatLabel = UILabel()
    let fourthSeatLabel = UILabel()
    
    let firstSeatReservationButton = UIButton()
    let secondSeatReservationButton = UIButton()
    let thirdSeatReservationButton = UIButton()
    let fourthSeatReservationButton = UIButton()
    
    let shareSeatsDescriptionView = UIView()
    
    let shareSeatsDescriptionLabel = UILabel()
    
    var seatsPadding = 20.0
    var seatsSize = 60.0
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 0.4)
        
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundImage.alpha = 0.5
        self.view.addSubview(self.backgroundImage)
        
        
        // TODO: 자리 상태 확인 가능하도록 변경 필요
        self.seatsView.translatesAutoresizingMaskIntoConstraints = false
        self.seatsView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        self.seatsView.layer.shadowColor = UIColor.black.cgColor
        self.seatsView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.seatsView.layer.shadowRadius = 3
        self.seatsView.layer.shadowOpacity = 0.5
        self.seatsView.layer.cornerRadius = 15
        self.seatsView.layer.masksToBounds = false
        
        self.view.addSubview(self.seatsView)
    
        self.seatsView.addSubview(firstSeat)
        self.seatsView.addSubview(secondSeat)
        self.seatsView.addSubview(thirdSeat)
        self.seatsView.addSubview(fourthSeat)
        
        self.firstSeat.translatesAutoresizingMaskIntoConstraints = false
        self.secondSeat.translatesAutoresizingMaskIntoConstraints = false
        self.thirdSeat.translatesAutoresizingMaskIntoConstraints = false
        self.fourthSeat.translatesAutoresizingMaskIntoConstraints = false
        
        self.firstSeatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.secondSeatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.thirdSeatLabel.translatesAutoresizingMaskIntoConstraints = false
        self.fourthSeatLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.firstSeatLabel.text = "Table A"
        self.secondSeatLabel.text = "Table B"
        self.thirdSeatLabel.text = "Table C"
        self.fourthSeatLabel.text = "Table D"
        
        self.firstSeatLabel.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.secondSeatLabel.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.thirdSeatLabel.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.fourthSeatLabel.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        
        self.firstSeatLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.secondSeatLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.thirdSeatLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.fourthSeatLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        
        self.seatsView.addSubview(firstSeatLabel)
        self.seatsView.addSubview(secondSeatLabel)
        self.seatsView.addSubview(thirdSeatLabel)
        self.seatsView.addSubview(fourthSeatLabel)
        
        self.firstSeatReservationButton.translatesAutoresizingMaskIntoConstraints = false
        self.secondSeatReservationButton.translatesAutoresizingMaskIntoConstraints = false
        self.thirdSeatReservationButton.translatesAutoresizingMaskIntoConstraints = false
        self.fourthSeatReservationButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.firstSeatReservationButton.setTitle("예약하기", for: .normal)
        self.secondSeatReservationButton.setTitle("예약하기", for: .normal)
        self.thirdSeatReservationButton.setTitle("예약하기", for: .normal)
        self.fourthSeatReservationButton.setTitle("예약하기", for: .normal)
        
        self.firstSeatReservationButton.setTitleColor(.white, for: .normal)
        self.secondSeatReservationButton.setTitleColor(.white, for: .normal)
        self.thirdSeatReservationButton.setTitleColor(.white, for: .normal)
        self.fourthSeatReservationButton.setTitleColor(.white, for: .normal)
        
        self.firstSeatReservationButton.setTitleColor(.black, for: .highlighted)
        self.secondSeatReservationButton.setTitleColor(.black, for: .highlighted)
        self.thirdSeatReservationButton.setTitleColor(.black, for: .highlighted)
        self.fourthSeatReservationButton.setTitleColor(.black, for: .highlighted)
        
        self.firstSeatReservationButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.secondSeatReservationButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.thirdSeatReservationButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.fourthSeatReservationButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        
        self.firstSeatReservationButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.secondSeatReservationButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.thirdSeatReservationButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.fourthSeatReservationButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        
        self.firstSeatReservationButton.layer.cornerRadius = 8
        self.secondSeatReservationButton.layer.cornerRadius = 8
        self.thirdSeatReservationButton.layer.cornerRadius = 8
        self.fourthSeatReservationButton.layer.cornerRadius = 8
        
        self.firstSeatReservationButton.layer.masksToBounds = true
        self.secondSeatReservationButton.layer.masksToBounds = true
        self.thirdSeatReservationButton.layer.masksToBounds = true
        self.fourthSeatReservationButton.layer.masksToBounds = true
        
        self.firstSeatReservationButton.addTarget(self, action: #selector(firstButtonClicked), for: .touchUpInside)
        self.secondSeatReservationButton.addTarget(self, action: #selector(secondButtonClicked), for: .touchUpInside)
        self.thirdSeatReservationButton.addTarget(self, action: #selector(thirdButtonClicked), for: .touchUpInside)
        self.fourthSeatReservationButton.addTarget(self, action: #selector(fourthButtonClicked), for: .touchUpInside)
        
        self.seatsView.addSubview(firstSeatReservationButton)
        self.seatsView.addSubview(secondSeatReservationButton)
        self.seatsView.addSubview(thirdSeatReservationButton)
        self.seatsView.addSubview(fourthSeatReservationButton)
        
        self.shareSeatsDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.shareSeatsDescriptionView.backgroundColor = .clear
        
        self.shareSeatsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.shareSeatsDescriptionLabel.numberOfLines = -1
        self.shareSeatsDescriptionLabel.textAlignment = .center
        self.shareSeatsDescriptionLabel.text = "※ 공유 주방 자리 예약 및 현황 파악이 가능한 페이지입니다. 반드시 해당 페이지를 통해 예약을 진행해주세요. ※"
        self.shareSeatsDescriptionLabel.textColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.shareSeatsDescriptionLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
        
        self.view.addSubview(self.shareSeatsDescriptionView)
        self.shareSeatsDescriptionView.addSubview(self.shareSeatsDescriptionLabel)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.seatsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            self.seatsView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.seatsView.widthAnchor.constraint(equalToConstant: 300),
            self.seatsView.heightAnchor.constraint(equalToConstant: 300),
            
            self.firstSeat.leadingAnchor.constraint(equalTo: self.seatsView.leadingAnchor, constant: self.seatsPadding),
            self.firstSeat.topAnchor.constraint(equalTo: self.seatsView.topAnchor, constant: self.seatsPadding),
            self.firstSeat.widthAnchor.constraint(equalToConstant: self.seatsSize),
            self.firstSeat.heightAnchor.constraint(equalToConstant: self.seatsSize),
            
            self.secondSeat.trailingAnchor.constraint(equalTo: self.seatsView.trailingAnchor, constant: -self.seatsPadding),
            self.secondSeat.topAnchor.constraint(equalTo: self.seatsView.topAnchor, constant: self.seatsPadding),
            self.secondSeat.widthAnchor.constraint(equalToConstant: self.seatsSize),
            self.secondSeat.heightAnchor.constraint(equalToConstant: self.seatsSize),
            
            self.thirdSeat.leadingAnchor.constraint(equalTo: self.seatsView.leadingAnchor, constant: self.seatsPadding),
            self.thirdSeat.bottomAnchor.constraint(equalTo: self.seatsView.bottomAnchor, constant: -self.seatsPadding - 45),
            self.thirdSeat.widthAnchor.constraint(equalToConstant: self.seatsSize),
            self.thirdSeat.heightAnchor.constraint(equalToConstant: self.seatsSize),
            
            self.fourthSeat.trailingAnchor.constraint(equalTo: self.seatsView.trailingAnchor, constant: -self.seatsPadding),
            self.fourthSeat.bottomAnchor.constraint(equalTo: self.seatsView.bottomAnchor, constant: -self.seatsPadding - 45),
            self.fourthSeat.widthAnchor.constraint(equalToConstant: self.seatsSize),
            self.fourthSeat.heightAnchor.constraint(equalToConstant: self.seatsSize),
            
            self.firstSeatLabel.topAnchor.constraint(equalTo: self.firstSeat.bottomAnchor, constant: 5),
            self.firstSeatLabel.centerXAnchor.constraint(equalTo: self.firstSeat.centerXAnchor),
            
            self.secondSeatLabel.topAnchor.constraint(equalTo: self.secondSeat.bottomAnchor, constant: 5),
            self.secondSeatLabel.centerXAnchor.constraint(equalTo: self.secondSeat.centerXAnchor),
            
            self.thirdSeatLabel.topAnchor.constraint(equalTo: self.thirdSeat.bottomAnchor, constant: 5),
            self.thirdSeatLabel.centerXAnchor.constraint(equalTo: self.thirdSeat.centerXAnchor),
            
            self.fourthSeatLabel.topAnchor.constraint(equalTo: self.fourthSeat.bottomAnchor, constant: 5),
            self.fourthSeatLabel.centerXAnchor.constraint(equalTo: self.fourthSeat.centerXAnchor),
            
            self.shareSeatsDescriptionView.topAnchor.constraint(equalTo: self.seatsView.bottomAnchor, constant: 10),
            self.shareSeatsDescriptionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.shareSeatsDescriptionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.shareSeatsDescriptionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.shareSeatsDescriptionLabel.topAnchor.constraint(equalTo: self.shareSeatsDescriptionView.topAnchor, constant: 10),
            self.shareSeatsDescriptionLabel.leadingAnchor.constraint(equalTo: self.shareSeatsDescriptionView.leadingAnchor, constant: 20),
            self.shareSeatsDescriptionLabel.trailingAnchor.constraint(equalTo: self.shareSeatsDescriptionView.trailingAnchor, constant: -20),
            
            self.firstSeatReservationButton.topAnchor.constraint(equalTo: self.firstSeatLabel.bottomAnchor, constant: 5),
            self.firstSeatReservationButton.centerXAnchor.constraint(equalTo: self.firstSeatLabel.centerXAnchor),
            self.firstSeatReservationButton.widthAnchor.constraint(equalToConstant: 80),
            
            self.secondSeatReservationButton.topAnchor.constraint(equalTo: self.secondSeatLabel.bottomAnchor, constant: 5),
            self.secondSeatReservationButton.centerXAnchor.constraint(equalTo: self.secondSeatLabel.centerXAnchor),
            self.secondSeatReservationButton.widthAnchor.constraint(equalToConstant: 80),
            
            self.thirdSeatReservationButton.topAnchor.constraint(equalTo: self.thirdSeatLabel.bottomAnchor, constant: 5),
            self.thirdSeatReservationButton.centerXAnchor.constraint(equalTo: self.thirdSeatLabel.centerXAnchor),
            self.thirdSeatReservationButton.widthAnchor.constraint(equalToConstant: 80),
            
            self.fourthSeatReservationButton.topAnchor.constraint(equalTo: self.fourthSeatLabel.bottomAnchor, constant: 5),
            self.fourthSeatReservationButton.centerXAnchor.constraint(equalTo: self.fourthSeatLabel.centerXAnchor),
            self.fourthSeatReservationButton.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func makeCalendarPopupView(popupString: String, tableNumber: Int) {
        let calendarViewController = UIViewController()
        calendarViewController.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
        
        let popupCalendarView = PopupCalendarView(tableNumber: tableNumber)
        popupCalendarView.setTableNumber(tableNumber: tableNumber)
        popupCalendarView.translatesAutoresizingMaskIntoConstraints = false
        popupCalendarView.backgroundColor = .white
        popupCalendarView.layer.cornerRadius = 10
        popupCalendarView.layer.masksToBounds = true
        
        calendarViewController.view.addSubview(popupCalendarView)
        
        
        // 최하단 테이블 설명 레이블
        let tableLabel = UILabel()
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        tableLabel.text = popupString
        tableLabel.textAlignment = .center
        tableLabel.numberOfLines = -1
        tableLabel.textColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        tableLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        
        calendarViewController.view.addSubview(tableLabel)
        
        
        NSLayoutConstraint.activate([
            popupCalendarView.topAnchor.constraint(equalTo: calendarViewController.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            popupCalendarView.leadingAnchor.constraint(equalTo: calendarViewController.view.leadingAnchor, constant: 25),
            popupCalendarView.trailingAnchor.constraint(equalTo: calendarViewController.view.trailingAnchor, constant: -25),
            popupCalendarView.bottomAnchor.constraint(equalTo: calendarViewController.view.bottomAnchor, constant: -100),
            tableLabel.bottomAnchor.constraint(equalTo: popupCalendarView.topAnchor, constant: -40),
            tableLabel.centerXAnchor.constraint(equalTo: popupCalendarView.centerXAnchor),
            tableLabel.leadingAnchor.constraint(equalTo: calendarViewController.view.leadingAnchor),
            tableLabel.trailingAnchor.constraint(equalTo: calendarViewController.view.trailingAnchor),
        ])
        
        calendarViewController.modalPresentationStyle = .overFullScreen
        calendarViewController.modalTransitionStyle = .crossDissolve
        present(calendarViewController, animated: true, completion: nil)
    }
    
    @objc func firstButtonClicked(_ sender: UIButton) {
        makeCalendarPopupView(popupString: "Table A 좌석 현황을 날짜별, 시간 별로 확인 가능합니다. \n (09:00 ~ 21:00, 2시간 단위로 예약이 가능합니다.)", tableNumber: 0)
    }
    
    @objc func secondButtonClicked(_ sender: UIButton) {
        makeCalendarPopupView(popupString: "Table B 좌석 현황을 날짜별, 시간 별로 확인 가능합니다. \n (09:00 ~ 21:00, 2시간 단위로 예약이 가능합니다.)", tableNumber: 1)
    }
    
    @objc func thirdButtonClicked(_ sender: UIButton) {
        makeCalendarPopupView(popupString: "Table C 좌석 현황을 날짜별, 시간 별로 확인 가능합니다. \n (09:00 ~ 21:00, 2시간 단위로 예약이 가능합니다.)", tableNumber: 2)
    }
    
    @objc func fourthButtonClicked(_ sender: UIButton) {
        makeCalendarPopupView(popupString: "Table D 좌석 현황을 날짜별, 시간 별로 확인 가능합니다. \n (09:00 ~ 21:00, 2시간 단위로 예약이 가능합니다.)", tableNumber: 3)
    }
    
}
