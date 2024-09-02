//
//  PopupCalendarView.swift
//  MarketProject
//
//  Created by 한건희 on 8/22/24.
//

import Foundation
import UIKit

class PopupCalendarView: UIView, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    var tableNumber: Int?
    
    // 상단 뒤로가기 및 년, 월 버튼
    let topUiView = UIView()
    let backButton = UIButton()
    let previousMonthButton = UIButton()
    let nextMonthButton = UIButton()
    let dateUiView = UIView()
    let yearLabel = UILabel()
    let yearStringLabel = UILabel()
    let monthLabel = UILabel()
    
    var topViewOffset = 45.0
    
    let calendarView = UICalendarView()
    var dateSelection : UICalendarSelectionSingleDate?
    
    
    init(tableNumber: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.tableNumber = tableNumber
        
        // self.tableNumber = tableNumber
        self.layer.borderColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = .white
        
        self.topUiView.translatesAutoresizingMaskIntoConstraints = false
        self.topUiView.backgroundColor = .clear
        self.addSubview(self.topUiView)
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.setImage(UIImage(named: "exit")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.backButton.addTarget(self, action: #selector(quitCalendarView), for: .touchUpInside)
        self.addSubview(self.backButton)
        
        self.previousMonthButton.translatesAutoresizingMaskIntoConstraints = false
        self.previousMonthButton.setImage(UIImage(named: "back-unselected")?.resized(to: CGSize(width: 25, height: 25)), for: .normal)
        self.topUiView.addSubview(self.previousMonthButton)
        
        self.dateUiView.translatesAutoresizingMaskIntoConstraints = false
        self.topUiView.addSubview(self.dateUiView)
        
        self.yearLabel.translatesAutoresizingMaskIntoConstraints = false
        self.yearLabel.text = "2024"
        self.yearLabel.textColor = .black
        self.yearLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        self.dateUiView.addSubview(self.yearLabel)
        
        self.yearStringLabel.translatesAutoresizingMaskIntoConstraints = false
        self.yearStringLabel.text = "년"
        self.yearStringLabel.textColor = .black
        self.yearStringLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        self.dateUiView.addSubview(self.yearStringLabel)
        
        self.monthLabel.translatesAutoresizingMaskIntoConstraints = false
        self.monthLabel.text = "08"
        self.monthLabel.textColor = .black
        self.monthLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        self.dateUiView.addSubview(self.monthLabel)
        
        self.nextMonthButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextMonthButton.setImage(UIImage(named: "forward-unselected")?.resized(to: CGSize(width: 25, height: 25)), for: .normal)
        self.topUiView.addSubview(self.nextMonthButton)
        
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        
        self.addSubview(lineView)
        
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.calendarView.wantsDateDecorations = true
        self.calendarView.locale = Locale(identifier: "ko_KR")
        self.calendarView.timeZone = TimeZone(secondsFromGMT: 0)! // UTC 시간대 사용
        self.calendarView.fontDesign = UIFontDescriptor.SystemDesign.default
        
        self.calendarView.delegate = self
        
        self.dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = self.dateSelection
        self.addSubview(self.calendarView)
        
        
        // 실제 캘린더 날짜
        
        // constraint 적용
        NSLayoutConstraint.activate([
            
            // TODO: calendarView 발견으로 잠시 안보이게 Bye~~ , exitButton만 아래로 잠깐 빼놓음 (24.08.22)
            self.topUiView.topAnchor.constraint(equalTo: self.topAnchor, constant:-50),
            self.topUiView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topUiView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topUiView.heightAnchor.constraint(equalToConstant: topViewOffset),
            
            self.previousMonthButton.centerYAnchor.constraint(equalTo: self.topUiView.centerYAnchor),
            self.previousMonthButton.trailingAnchor.constraint(equalTo: self.dateUiView.leadingAnchor, constant: -10),
            self.previousMonthButton.heightAnchor.constraint(equalToConstant: 30),
            self.previousMonthButton.widthAnchor.constraint(equalToConstant: 30),
            
            self.dateUiView.centerYAnchor.constraint(equalTo: self.topUiView.centerYAnchor),
            self.dateUiView.centerXAnchor.constraint(equalTo: self.topUiView.centerXAnchor, constant: 15),
            self.dateUiView.widthAnchor.constraint(equalToConstant: 150),
            self.dateUiView.heightAnchor.constraint(equalTo: self.topUiView.heightAnchor),
            
            self.yearLabel.centerYAnchor.constraint(equalTo: self.dateUiView.centerYAnchor),
            self.yearLabel.trailingAnchor.constraint(equalTo: self.yearStringLabel.leadingAnchor, constant: -10),
            
            self.yearStringLabel.centerYAnchor.constraint(equalTo: self.dateUiView.centerYAnchor),
            self.yearStringLabel.centerXAnchor.constraint(equalTo: self.dateUiView.centerXAnchor),
            
            self.monthLabel.centerYAnchor.constraint(equalTo: self.dateUiView.centerYAnchor),
            self.monthLabel.leadingAnchor.constraint(equalTo: self.yearStringLabel.trailingAnchor, constant: 10),
            
            self.nextMonthButton.centerYAnchor.constraint(equalTo: self.topUiView.centerYAnchor),
            self.nextMonthButton.leadingAnchor.constraint(equalTo: self.dateUiView.trailingAnchor, constant: -10),
            self.nextMonthButton.widthAnchor.constraint(equalToConstant: 30),
            self.nextMonthButton.heightAnchor.constraint(equalToConstant: 30),
            
            lineView.topAnchor.constraint(equalTo: self.topUiView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.topUiView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.topUiView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.backButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            self.backButton.trailingAnchor.constraint(equalTo: self.topUiView.trailingAnchor, constant: -10),
            self.backButton.heightAnchor.constraint(equalToConstant: 30),
            self.backButton.widthAnchor.constraint(equalToConstant: 30),
            
            self.calendarView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 5),
            self.calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        // 해당 날짜 예약 현황 나열
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateString = dateFormatter.string(from: (dateComponents?.date)!)
        
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.findViewController()!.present(loadingViewController, animated: true)
        
        let viewController = ReserveTableViewController(date: dateString, tableNumber: tableNumber!)
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        DBManager.instance.getTableTimeStatus(date: dateString, tableNumber: self.tableNumber!) { timeList, usersInfo in
            
            DispatchQueue.main.async {
                loadingViewController.dismiss(animated: true, completion: {
                    viewController.setTimeViews(isAvailables: timeList , date: dateString,reservedUsersInfo: usersInfo)
                    self.findViewController()?.present(viewController, animated: true)
                })
            }
        }
        
        self.dateSelection?.selectedDate = nil
    }
    
//    // 캘린더에 공유 테이블 현황 표시 (해당 일자에 예약 가능한 시간이 많으면 초록 동그라미, 적으면 빨간 동그라미) - 아래 delegate는 모든 캘린더에 표시되는 날짜에 대해 실행됨 (달력 넘겨도 실행)
//    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//        
//        // TODO: 정상적으로 업데이트 되도록 수정 필요
//        return .customView {
//            
//            let year = String(describing: dateComponents.year!)
//            let month = String(describing: dateComponents.month!)
//            let day = String(describing: dateComponents.day!)
//            
//            let decoration = UIImageView()
//            
//            DBManager.instance.getTableAvailabilityCount(date: "\(year)-\(month)-\(day)", tableNumber: self.tableNumber!) { availableCount in
//                
//                if availableCount > 4 {
//                    decoration.image = UIImage(named: "green-circle")?.resized(to: CGSize(width: 20, height: 20))
//                }
//                else if availableCount > 2 {
//                    decoration.image = UIImage(named: "red-circle")?.resized(to: CGSize(width: 20, height: 20))
//                }
//                else {
//                    decoration.image = UIImage(named: "red-circle")?.resized(to: CGSize(width: 20, height: 20))
//                }
//                
//                return decoration
//            }
//            
//            return decoration
//        }
//    }
    
    func setTableNumber(tableNumber: Int) {
        self.tableNumber = tableNumber
    }
    
    // 예약 시 Date 형으로 저장하기 위함으로 시간까지 있어야 함 -> Deprecated
    func getDate(year: Int, month: Int, day: Int, hour: Int) -> Date? {
        let dateString = "\(year)-\(month)-\(day) \(hour):00"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // (UTC 기준 시)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // HH 는 24시 표현
        let date = dateFormatter.date(from: dateString)
        
        return date
    }
    
    @objc func quitCalendarView(_ sender: UIButton) {
        let superViewController = self.findViewController()
        superViewController!.dismiss(animated: true, completion: nil)
    }
    
    
}
