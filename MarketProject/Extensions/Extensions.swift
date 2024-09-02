//
//  Extensions.swift
//  MarketProject
//
//  Created by 한건희 on 8/11/24.
//

import UIKit


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static var currentResponder: UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap() {
        Static.responder = self
    }
}

extension UIViewController {
    
    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        guard let currentTextField = UIResponder.currentResponder as? UIView else { return }
        
        // keyboard 상단 y 위치
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        // 현재 선택한 텍스트 필드 Frame 값
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        
        if view.frame.origin.y == 0 && textFieldBottomY > keyboardTopY {
            view.frame.origin.y -= textFieldBottomY - keyboardTopY + 50
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIImageView {
    func startBouncing() {
            // 튀는 높이와 지속 시간 설정
            let bounceHeight: CGFloat = 20.0
            let duration: TimeInterval = 0.5
            
            // 애니메이션 구현
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: [.autoreverse, .repeat, .allowUserInteraction],
                           animations: {
                // 위로 이동
                self.transform = CGAffineTransform(translationX: 0, y: -bounceHeight)
            }, completion: nil)
        }

        func stopBouncing() {
            // 애니메이션 중지
            self.layer.removeAllAnimations()
            // 원래 위치로 되돌리기
            self.transform = .identity
        }
}
