//
//  CameraViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/09/06.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var btnX: UIButton!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    
    var captureSession: AVCaptureSession!
    
    var backCamera: AVCaptureDevice!
        var frontCamera: AVCaptureDevice!
        var backInput: AVCaptureInput!
        var frontInput: AVCaptureInput!
    
    var previewLayer: AVCaptureVideoPreviewLayer!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            setupAndStartCaptureSession()
        }
    
    // MARK: - Camera Setup
      func setupAndStartCaptureSession() {
          DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
              // 세션 초기화
              captureSession = AVCaptureSession()
              // 구성(configuration) 시작
              captureSession.beginConfiguration()
              
              // session specific configuration
                // 세션 프리셋을 설정하기 전에 지원 여부를 확인해야 합니다.
                if captureSession.canSetSessionPreset(.photo) {
                    captureSession.sessionPreset = .photo
                }
                
                // 사용 가능한 경우 세션이 자동으로 광역 색상을 사용해야 하는지 여부를 지정합니다.
                captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
              
              // Setup inputs
                          setupInputs()
              
              // UI 관련 부분은 메인 스레드에서 실행되어야 합니다.
                       DispatchQueue.main.async {
                           // 미리보기 레이어 셋업
                           self.setupPreviewLayer()
                       }
              
              // commit configuration: 단일 atomic 업데이트에서 실행 중인 캡처 세션의 구성에 대한 하나 이상의 변경 사항을 커밋합니다.
              self.captureSession.commitConfiguration()
              // 캡처 세션 실행
              captureSession.startRunning()
          }
      }
    
    func setupInputs() {
            // 후면(back) 및 전면(front) 카메라
            if let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
               let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                self.backCamera = backCamera
                self.frontCamera = frontCamera
            } else {
                fatalError("No cameras.")
            }
            
            // 이제 기기로부터 입력 오브젝트를 만들어야 합니다.
            guard let backInput = try? AVCaptureDeviceInput(device: self.backCamera) else {
                fatalError("could not create input device from back camera")
            }
            self.backInput = backInput
            if !captureSession.canAddInput(self.backInput) {
                fatalError("could not add back camera input to capture session")
            }
            
            guard let frontInput = try? AVCaptureDeviceInput(device: self.frontCamera) else {
                fatalError("could not create input device from front camera")
            }
            self.frontInput = frontInput
            if !captureSession.canAddInput(self.frontInput) {
                fatalError("could not add front camera input to capture session")
            }
            // **후면 카메라 입력을 세션에 연결합니다.
            captureSession.addInput(backInput)
        }
    
    func setupPreviewLayer() {
           previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
           view.layer.insertSublayer(previewLayer, below: btnGallery.layer)
           previewLayer.frame = self.view.frame
       }

    @IBAction func gearButtonTouched(_ sender: Any) {
    }
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
    }
    
    @IBAction func galleryButtonTouched(_ sender: Any) {
    }
    
    @IBAction func flashButtonTouched(_ sender: Any) {
    }
    @IBAction func xButtonTouched(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
