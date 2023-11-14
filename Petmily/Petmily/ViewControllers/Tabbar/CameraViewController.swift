//
//  CameraViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/09/06.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    
    // http://yoonbumtae.com/?p=5762
    @IBOutlet weak var btnX: UIButton!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var vPreview: UIView!
    @IBOutlet weak var img: UIImageView!
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var stillImageOutput: AVCapturePhotoOutput!
    
    var movieFileOutput: AVCaptureMovieFileOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            let cameraInput = try AVCaptureDeviceInput(device: captureDevice)
            
            movieFileOutput = AVCaptureMovieFileOutput()
            
            captureSession.addInput(cameraInput)
            captureSession.sessionPreset = .hd1280x720
            captureSession.addOutput(movieFileOutput)
            captureSession.commitConfiguration()
        } catch {
            print(error)
        }
        //preview
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.vPreview.bounds
        }
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        self.vPreview.layer.addSublayer(videoPreviewLayer)
        DispatchQueue.global(qos: .background).async {            self.captureSession.startRunning()
        }
        // Do any additional setup after loading the view.
    }
    
    func startRecording() {
        let outputFileName = NSUUID().uuidString
        let outputFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent(outputFileName).appending(".mov")
        let outputURL = URL(fileURLWithPath: outputFilePath)
        
        movieFileOutput.startRecording(to: outputURL, recordingDelegate: self)
    }
    
    func stopRecording() {
        movieFileOutput.stopRecording()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        setupAndStartCaptureSession()
    }
    
    private func switchCamera(captureSession: AVCaptureSession?) {
        captureSession?.beginConfiguration()
        let currentInput = captureSession?.inputs.first as? AVCaptureDeviceInput
        captureSession?.removeInput(currentInput!)
        
        let newCameraDevice = currentInput?.device.position == .back ? camera(with: .front) : camera(with: .back)
        let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice!)
        captureSession?.addInput(newVideoInput!)
        captureSession?.commitConfiguration()
    }
    
    private func camera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
        return devices.filter { $0.position == position }.first
    }
    
    //    func didTapBtnTakePicture(stillImageOutput: AVCaptureMovieFileOutput) {
    ////        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.h264])
    ////        settings.flashMode = flashMode.value == .off ? .off : .on
    //        stillImageOutput.startRecording(to: settings, recordingDelegate: self)
    //    }
    
    @IBAction func gearButtonTouched(_ sender: Any) {
        
    }
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
        if !movieFileOutput.isRecording {
            startRecording()
        } else {
            stopRecording()
        }
        //        didTapBtnTakePicture(stillImageOutput: stillImageOutput)
        //        stillImageOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self as AVCapturePhotoCaptureDelegate)
        
    }
    
    @IBAction func flashButtonTouched(_ sender: UIButton) {
        //카메라 디바이스 가져오기
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        //플래시를 지원한다면
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                //현재 off상태이면 on시키기
                if device.torchMode == .off {
                    device.torchMode = .on
                    //플래시 버튼 이미지 변경
                    sender.setImage(UIImage.init(systemName: "lightbulb"), for: .normal)
                }
                //현재 on상태이면 off시키기
                else {
                    device.torchMode = .off
                    //플래시 버튼 이미지 변경
                    sender.setImage(UIImage.init(systemName: "lightbulb.slash"), for: .normal)
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
        //        didTapBtnTakePicture(stillImageOutput: stillImageOutput)
    }
    
    @IBAction func conversionCameraButtonTouched(_ sender: Any) {
        switchCamera(captureSession: captureSession)
    }
    
    @IBAction func xButtonTouched(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension CameraViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        // 비디오 촬영이 시작됐을 때의 동작
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
        } else {
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil)
        }
    }
}
