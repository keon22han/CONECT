import UIKit
import DropDown

class SharingRefrigeratorViewController: UIViewController {

    var refrigeratorsInfo: [RefrigeratorInformation]?
    // 선택된 냉장고 Number
    let selectedRefrigeatorNumber = 0
    
    // UI Contents
    let refrigeratorFoodsInfoScrollView = UIScrollView()
    
    var refrigeratorFoodsInfoStackView: RefrigeratorFoodsInfoStackView?
    let refrigeratorSegmentControl = UISegmentedControl()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refrigeratorSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.refrigeratorSegmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        self.view.addSubview(self.refrigeratorSegmentControl)
        
        self.refrigeratorFoodsInfoScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.refrigeratorFoodsInfoScrollView.backgroundColor = .clear
        self.refrigeratorFoodsInfoScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.refrigeratorFoodsInfoScrollView)
        
        NSLayoutConstraint.activate([
            self.refrigeratorSegmentControl.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.refrigeratorSegmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.refrigeratorSegmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            
            self.refrigeratorFoodsInfoScrollView.topAnchor.constraint(equalTo: self.refrigeratorSegmentControl.bottomAnchor, constant: 20),
            self.refrigeratorFoodsInfoScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.refrigeratorFoodsInfoScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.refrigeratorFoodsInfoScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        setRefrigeratorInfoUI()
        
//        DBManager.instance.getRefrigeratorsInfo(completion: {
//            
//        })
    }
    
    private func setRefrigeratorInfoUI() {
        DBManager.instance.getRefrigeratorsBaseInfo(completion: { success, infos in
            
            if !success {
                return
            }
            
            self.refrigeratorsInfo = infos!
            
            DispatchQueue.main.async {
                self.refrigeratorFoodsInfoStackView = RefrigeratorFoodsInfoStackView(refrigeratorInfo: self.refrigeratorsInfo![0])
                
                for refrigeratorIndex in stride(from: 0, to: self.refrigeratorsInfo!.count, by: 1) {
                    self.refrigeratorSegmentControl.insertSegment(withTitle: self.refrigeratorsInfo![refrigeratorIndex].refrigeratorName, at: refrigeratorIndex, animated: true)
                }
                
                self.refrigeratorFoodsInfoStackView!.translatesAutoresizingMaskIntoConstraints = false
                self.refrigeratorFoodsInfoScrollView.addSubview(self.refrigeratorFoodsInfoStackView!)
                
                NSLayoutConstraint.activate([
                    self.refrigeratorFoodsInfoStackView!.topAnchor.constraint(equalTo: self.refrigeratorFoodsInfoScrollView.contentLayoutGuide.topAnchor, constant: 20),
                    self.refrigeratorFoodsInfoStackView!.bottomAnchor.constraint(equalTo: self.refrigeratorFoodsInfoScrollView.contentLayoutGuide.bottomAnchor, constant: -20),
                    self.refrigeratorFoodsInfoStackView!.widthAnchor.constraint(equalTo: self.refrigeratorFoodsInfoScrollView.widthAnchor)
                ])
            }
        })
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.present(loadingViewController, animated: true)
        
        // 기존 스택 뷰 제거
        self.refrigeratorFoodsInfoStackView?.removeFromSuperview()
        
        // 새로운 스택 뷰 생성
        self.refrigeratorFoodsInfoStackView = RefrigeratorFoodsInfoStackView(refrigeratorInfo: self.refrigeratorsInfo![sender.selectedSegmentIndex])
        self.refrigeratorFoodsInfoStackView!.translatesAutoresizingMaskIntoConstraints = false
        
        // 새로운 스택 뷰 추가
        self.refrigeratorFoodsInfoScrollView.addSubview(self.refrigeratorFoodsInfoStackView!)
        
        // 레이아웃 제약 조건 추가
        NSLayoutConstraint.activate([
            self.refrigeratorFoodsInfoStackView!.topAnchor.constraint(equalTo: self.refrigeratorFoodsInfoScrollView.contentLayoutGuide.topAnchor, constant: 20),
            self.refrigeratorFoodsInfoStackView!.bottomAnchor.constraint(equalTo: self.refrigeratorFoodsInfoScrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            self.refrigeratorFoodsInfoStackView!.widthAnchor.constraint(equalTo: self.refrigeratorFoodsInfoScrollView.widthAnchor)
        ])
        
        loadingViewController.dismiss(animated: true)
    }
}
