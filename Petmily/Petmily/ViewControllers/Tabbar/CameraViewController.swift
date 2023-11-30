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
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    var movieFileOutput = AVCaptureMovieFileOutput()
    var audioFileOutput = AVCaptureAudioDataOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCamera()
    }
    
    func setCamera() {
        self.captureSession = AVCaptureSession()
        self.captureSession.beginConfiguration()
        
        // AVCaptureSession 설정
        guard let videoDevice = AVCaptureDevice.default(for: AVMediaType.video),
              let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
              let audioInput = try? AVCaptureDeviceInput(device: audioDevice) else {
            // Error handling
            return
        }
        
        self.movieFileOutput = AVCaptureMovieFileOutput()
        self.audioFileOutput = AVCaptureAudioDataOutput()
        
        self.captureSession.addInput(videoInput)
        self.captureSession.addInput(audioInput)
        self.captureSession.sessionPreset = .hd1280x720
        self.captureSession.addOutput(self.movieFileOutput)
        self.captureSession.addOutput(self.audioFileOutput)
        self.captureSession.commitConfiguration()
        
        self.setPreviewCamera()
    }
    
    func setPreviewCamera() {
        //preview
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.vPreview.bounds
        }
        self.videoPreviewLayer.videoGravity = .resizeAspectFill
        DispatchQueue.main.async {
            self.vPreview.layer.addSublayer(self.videoPreviewLayer)
        }
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
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
    
    private func camera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        
        let devices = discoverySession.devices
        return devices.filter { $0.position == position }.first
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
    
    
    @IBAction func gearButtonTouched(_ sender: Any) {
        
    }
    
    @IBAction func cameraButtonTouched(_ sender: UIButton) {
        if !movieFileOutput.isRecording {
            startRecording()
            sender.setTitle("Recording", for: .normal)
        } else {
            stopRecording()
            sender.setTitle("Record", for: .normal)
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
