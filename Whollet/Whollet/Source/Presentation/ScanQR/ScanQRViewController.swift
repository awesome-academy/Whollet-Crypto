import AVFoundation
import UIKit
import Reusable

final class ScanQRViewController: UIViewController {
    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet private weak var scanNowButton: UIButton!
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var qrCodeFrameView: UIView?
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private var qrText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        self.navigationController?.isNavigationBarHidden = true
        implementingVideoCapture()
        captureSession.startRunning()
    }
    
    private func configView() {
        scanNowButton.fullCornerRadius()
        scanNowButton.resizeTextWithHeight()
    }
    
    private func implementingVideoCapture() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            showToast(message: AppConstants.Strings.failedGetCamera, font: .systemFont(ofSize: 15 * UIScreen.resizeHeight))
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            return
        }
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        cameraView.layer.addSublayer(videoPreviewLayer!)
        captureSession.startRunning()
        qrCodeFrameView = UIView()

        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            cameraView.addSubview(qrCodeFrameView)
            cameraView.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    @IBAction private func scanNowOnClick(_ sender: Any) {
        appDelegate?.transactionInput.address = qrText
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
}

extension ScanQRViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
    
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            if let result = metadataObj.stringValue {
                qrText = result
            }
        }
    }
}

extension ScanQRViewController: StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "ScanQRViewController", bundle: nil)
}
