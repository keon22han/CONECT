import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Your device does not support camera.")
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Unable to initialize the camera.")
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            print("Could not add input to the session")
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Could not add output to the session")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            qrCodeDetected(code: stringValue)
        }
    }
    
    func qrCodeDetected(code: String) {
        print("QR Code Detected: \(code)")
        
        self.captureSession.stopRunning()
        
        // 장바구니 사용 팝업 띄우기
        let shoppingCartReservationViewController = ShoppingCartReservationViewController(yesCommand: { 
            DBManager.instance.reserveShoppingCart(shoppingCartIdentifier: code)
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }, noCommand: { })
        shoppingCartReservationViewController.modalPresentationStyle = .overFullScreen
        shoppingCartReservationViewController.modalTransitionStyle = .crossDissolve
        self.present(shoppingCartReservationViewController, animated: true)
    }
}
