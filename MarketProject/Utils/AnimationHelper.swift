//
//  AnimationHelper.swift
//  MarketProject
//
//  Created by 한건희 on 8/31/24.
//

import Foundation
import UIKit

class AnimationHelper {
    
    public static let instance = AnimationHelper()
    
    private init() {
        
    }
    
    public func startViewSpringAnimation (view: UIView, duration: Double, scale: Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            view.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            
            UIView.animate(withDuration: duration, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
            
        }
    }
    
    public func startViewSpringAnimationRepeat(view: UIView, duration: Double, scale: Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            view.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            
            UIView.animate(withDuration: duration, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                
            }) { (flag) in
                self.startViewSpringAnimationRepeat(view: view, duration: duration, scale: scale)
            }
        }) { (flag) in
            
        }
    }
    
    public func startViewtransitionAnimation(view: UIView, targetFrame: CGRect, duration: Double) {
        
        // Step 1: Expand the view
        UIView.animate(withDuration: duration, animations: {
            view.frame = targetFrame
        }, completion: nil)
    }
}
