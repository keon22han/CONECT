//
//  PermissionManager.swift
//  MarketProject
//
//  Created by 한건희 on 8/30/24.
//

import Foundation
import AVFoundation
import UIKit
import Photos

final class PermissionManager: ObservableObject {
    
    static let instance = PermissionManager()
    
    private init() {
        
    }
    
    func requestCameraPermission(parentViewController: UIViewController, completion: @escaping((Bool) -> Void)) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch cameraAuthorizationStatus {
            case .denied, .restricted :
                DispatchQueue.main.async {
                    let alertViewController = AlertButtonViewController(mainTitle: "카메라 이용을 위해서는 카메라 권한 설정을 '켬'으로 설정해주세요.", subTitle: "'예' 버튼 클릭 시 설정창으로 이동합니다.", yesClickCallback: {
                        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSettings)
                        }
                    }, noClickCallback: { })
                    alertViewController.modalPresentationStyle = .overFullScreen
                    alertViewController.modalTransitionStyle = .crossDissolve
                    parentViewController.present(alertViewController, animated: true)
                }
            case .notDetermined:
                if granted {
                    print("Camera: 권한 허용")
                    completion(true)
                } else {
                    print("Camera: 권한 거부")
                    completion(false)
                }
            case .authorized:
                completion(true)
            @unknown default:
                completion(false)
            }
            
            
        })
    }
    
    func requestAlbumPermission(parentViewController: UIViewController, completion: @escaping((Bool) -> Void)) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .denied:
            DispatchQueue.main.async {
                let alertViewController = AlertButtonViewController(mainTitle: "앨범 이용을 위해서는 앨범 접근 권한 설정을 '켬'으로 설정해주세요.", subTitle: "'예' 버튼 클릭 시 설정창으로 이동합니다.", yesClickCallback: {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                }, noClickCallback: { })
                alertViewController.modalPresentationStyle = .overFullScreen
                alertViewController.modalTransitionStyle = .crossDissolve
                parentViewController.present(alertViewController, animated: true)
            }
            case .authorized:
                print("허용")
                completion(true)
            case .notDetermined, .restricted:
                print("아직 결정하지 않은 상태")
                PHPhotoLibrary.requestAuthorization { state in
                    if state == .authorized {
                        completion(true)
                    } else {
                        // parentViewController.dismiss(animated: true, completion: nil)
                    }
                }
            default:
                break
            }
    }
}
