//
//  BasdViewController.swift
//  PetUI
//
//  Created by t2023-m0049 on 2023/08/16.
//

import AVKit
import MobileCoreServices
import Photos
import PhotosUI
import UIKit

class AddViewController: BaseViewController{
    
    var selectedInfo: InfoModel?
    var selectedUser: UserModel?
    
   
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var dailyImg: UIImageView!
    
    /** @brief 플러스버튼테두리구현뷰 */
    @IBOutlet var vLinePattern: UIView!
    
    /** @brief 완료버튼 */
    @IBOutlet var completeBtn: UIButton!
    
    /** @brief 뷰1 */
    @IBOutlet var view1: UIScrollView!
    
    /** @brief 뷰2 */
    @IBOutlet var view2: UIScrollView!
    
    /** @brief 세그먼트버튼 */
    @IBOutlet var segBtn: UISegmentedControl!
    
    /** @brief 정보공유콘텐츠플레이스홀더 */
    @IBOutlet var lblPlaceholder: UILabel!
    
    /** @brief 정보공유해시태그 */
    @IBOutlet var tfInfoHashTag: UITextField! // 정보공유해시태그
    
    /** @brief 정보공유콘텐츠창 */
    @IBOutlet var txtvContents: UITextView! // 정보공유콘텐츠창
    
    /** @brief 정보공유제목 */
    @IBOutlet var infoTitle: UITextField! // 정보공유제목
    
    /** @brief 데일리 해시태그 */
    @IBOutlet var tfDailyHashTag: UITextField! // 데일리 해시태그
    
    /** @brief 플러스버튼 */
    @IBOutlet var plusBtn: UIButton!
    
    /** @brief 데일리 간단한 설명글 */
    @IBOutlet var shortTxtF: UITextField!
    @IBOutlet var vPlayer: UIView!
    @IBOutlet weak var csrConfirmBottomMargin: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    var previousText: String = ""
    
    var dailyImageURL: String?
    var avQueuePlayer : AVQueuePlayer? // 일련의 플레이어 항목을 재생하는 개체
    var avplayerLayer : AVPlayerLayer?
    var imgORVideo: String = "video"
    
    var user: UserModel?
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtvContents.delegate = self
        tfInfoHashTag.delegate = self
        tfDailyHashTag.delegate = self
        
        imagePicker.delegate = self
        /* changedHashTagColor(tfInfoHashTag, shouldChangeCharactersIn: <#T##NSRange#>, replacementString: <#T##String#>)
         changedHashTagColor(tfDailyHashTag, shouldChangeCharactersIn: <#T##NSRange#>, replacementString: <#T##String#>) */
        
        FirestoreService().getUserData { result in
            self.user = result
            print(result)
        }
        
        NSLayoutConstraint.activate([
            vPlayer.topAnchor.constraint(equalTo: vPlayer.topAnchor),
            vPlayer.leadingAnchor.constraint(equalTo: vPlayer.leadingAnchor),
            vPlayer.trailingAnchor.constraint(equalTo: vPlayer.trailingAnchor),
            vPlayer.bottomAnchor.constraint(equalTo: vPlayer.bottomAnchor)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
                // view2에 대한 Notification 등록
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillShowForView2(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillHideForView2(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtvContents.layer.borderWidth = 1.0
        txtvContents.layer.borderColor = UIColor.lightGray.cgColor
        
        setLineDot(view: vLinePattern, color: .black, radius: 10)
    }
    
    func setLineDot(view: UIView, color: UIColor, radius: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = [2, 2]
        borderLayer.frame = view.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
        view.layer.addSublayer(borderLayer)
    }
    
    // break point?
    
    func setLineDot(view: UIView, color: String, radius: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor(named: color)?.cgColor
        borderLayer.lineDashPattern = [2, 2]
        borderLayer.frame = view.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
        view.layer.addSublayer(borderLayer)
    }
    
    func setProfileImage() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        dailyImg.isUserInteractionEnabled = true
        dailyImg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageViewTapped(_ sender: AnyObject) {
        //        requestPhotosPermission()
        requestCollection()
    }
    
    /** @brief textField enter Event, next */
    @objc func _keyboardWillShow(_ notification: Notification) {
           if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               let keyboardRectangle = keyboardFrame.cgRectValue
               let keyboardHeight = keyboardRectangle.height
               var inset:UIEdgeInsets = self.view1.contentInset
               inset.bottom = keyboardHeight - Common.kBottomHeight
               
               view1.contentInset = inset
               self.csrConfirmBottomMargin.constant = inset.bottom
           }
       }

       @objc func _keyboardWillHide(_ notification: Notification) {
           view1.contentInset = .zero
           csrConfirmBottomMargin.constant = 0
       }

       @objc func _keyboardWillShowForView2(_ notification: Notification) {
           if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               let keyboardRectangle = keyboardFrame.cgRectValue
               let keyboardHeight = keyboardRectangle.height
               var inset:UIEdgeInsets = self.view2.contentInset
               inset.bottom = keyboardHeight - Common.kBottomHeight
               
               view2.contentInset = inset
               self.csrConfirmBottomMargin.constant = inset.bottom
           }
       }

       @objc func _keyboardWillHideForView2(_ notification: Notification) {
           view2.contentInset = .zero
           csrConfirmBottomMargin.constant = 0
       }
    
    private func requestPhotosPermission() {
        let photoAuthorizationStatusStatus = PHPhotoLibrary.authorizationStatus()
        CommonUtil.print(output: photoAuthorizationStatusStatus)
        switch photoAuthorizationStatusStatus {
        case .authorized:
            print("Photo Authorization status is authorized.")
            requestCollection()
        case .denied:
            print("Photo Authorization status is denied.")
        case .notDetermined:
            print("Photo Authorization status is not determined.")
            PHPhotoLibrary.requestAuthorization {
                status in
                switch status {
                case .authorized:
                    print("User permiited.")
                    self.requestCollection()
                case .denied:
                    print("User denied.")
                default:
                    break
                }
            }
        case .restricted:
            print("Photo Authorization status is restricted.")
        default:
            break
        }
    }
    
    func requestCollection() {
        DispatchQueue.main.async {
            self.imagePicker.sourceType = .photoLibrary // 앨범 지정 실시
            self.imagePicker.allowsEditing = false // 편집을 허용하지 않음
            self.present(self.imagePicker, animated: false, completion: nil)
        }
    }
    
    func requestAddDaily() {
        if shortTxtF.text ?? "" != "" {
            FirestoreService().addDailyDocument(content: shortTxtF.text ?? "", hashTag: tfDailyHashTag.text ?? "", imageURL: imageUrl ?? "") { reuslt in
                BaseTabbarController().moveToTabBarIndex(index: .Daily)
            }
        } else {
            CommonUtil().showOneButtonAlertView(title: "내용을 입력하세요.", message: "")
        }
    }
    
    func requsetAddInfo() {
        if infoTitle.text ?? "" != "" {
            let nowDate = Date() // 현재의 Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let str = dateFormatter.string(from: nowDate)
            FirestoreService().addInfoDocument(title: infoTitle.text ?? "", content: txtvContents.text ?? "", date: str, hashTag: tfInfoHashTag.text ?? "", imageURL: imageUrl ?? "") { result in
                BaseTabbarController().moveToTabBarIndex(index: .Info)
            }
        } else {
            CommonUtil().showOneButtonAlertView(title: "제목을 입력하세요.", message: "")
        }
    }
    
    func urlToThumbnail(_ url: URL) -> UIImage {
        let myUrl = url
        let myAsset = AVAsset(url: myUrl)
        let imageGenerator = AVAssetImageGenerator(asset: myAsset)
        let time: CMTime = CMTime(value: 600, timescale: 600)
        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: nil) else { fatalError() }
        let uiImage = UIImage(cgImage: cgImage)
        return uiImage
    }
    
    // 액션 이쪽으로 옮길것
    
    @IBAction func plusBtn(_ sender: UIButton) {
        // +버튼 눌렀을 때 갤러리가 뜨게해야한다(사진이나 동영상 첨부를 위해서)
        imgORVideo = "video"
        showVideoPicker()
    }
    
    @IBAction func segBtn(_ sender: UISegmentedControl) {
        // 세그먼트버튼 눌렀을 때 뷰끼리의 화면전환을 알파값으로 구현 실패
        if sender.selectedSegmentIndex == 0 {
            view1.isHidden = false
            view2.isHidden = true
        } else {
            view1.isHidden = true
            view2.isHidden = false
        }
    }
    
    @IBAction func uploadBtn(_ sender: UIButton) {
        // 업로드 버튼 눌렀을 때 갤러리로 이동
        imgORVideo = "img"
        requestCollection()
    }
    
    @IBAction func completeBtn(_ sender: UIButton) {
        //완료 버튼 눌렀을 때 현재 창이 꺼지면서 입력했던 자료들이 데일리와 정보공유 게시판에 올라가는 것을 구현해라
        switch imgORVideo {
        case "img":
            requsetAddInfo()
        case "video":
            requestAddDaily()
        default:
            break
        }
        
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblPlaceholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lblPlaceholder.isHidden = !txtvContents.text.isEmpty
    }
}

extension AddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // 현재 입력된 텍스트 가져오기
            let currentText = textField.text ?? ""
            
            // 띄어쓰기가 입력되었는지 확인
            if string == " " {
                // 이전 텍스트를 파란색으로 변경한 NSAttributedString 생성
                let attributedString = NSMutableAttributedString(string: currentText)
                attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: currentText.count))
                
                // 텍스트 필드에 적용
                textField.attributedText = attributedString
            }
            
            return true
        }
    
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showVideoPicker() {
        let videoPicker = UIImagePickerController()
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.delegate = self
        present(videoPicker, animated: true, completion: nil)
    }

    // 선택한 비디오를 AVQueuePlayer로 재생
    func playVideoWithURL(_ videoURL: URL) {
            self.avQueuePlayer = AVQueuePlayer(url: videoURL)
            self.avplayerLayer = AVPlayerLayer(player: self.avQueuePlayer!)
            self.avplayerLayer?.frame = self.vPlayer.bounds
            self.avplayerLayer?.fillMode = .both // 애니메이션 시작과 끝에 어떻게 보일지 설정하는 속성
            self.avplayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.vPlayer.layer.addSublayer(self.avplayerLayer!)
            self.avQueuePlayer?.play()
            self.vPlayer.backgroundColor = .black
        
        // MARK: HAVETO 작동 x
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        switch imgORVideo {
        case "img":
            // 이미지 뷰에 앨범에서 선택한 사진 표시
            guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            FirebaseStorageManager.uploadImage(image: selectedImage, pathRoot: user!.id)
            { url in
                if let url = url {
                    self.imageUrl = url.absoluteString
                    FirebaseStorageManager.downloadImage(urlString: self.imageUrl!) { [weak self] image in
                        self?.imageView.image = image
                        
                    }
                }
                
            }
            
            // 이미지 파커 닫기
            dismiss(animated: true, completion: nil)
        case "video":
            picker.dismiss(animated: true, completion: nil)
            
            if let videoURL = info[.mediaURL] as? URL {
                FirebaseStorageManager.uploadVideo(file: videoURL) {
                    url in
                    if let url = url {
                        self.imageUrl = url.absoluteString
                        print(self.imageUrl!)
                        FirebaseStorageManager.downloadVideo(urlString: self.imageUrl!) { [weak self] video in
                            self!.playVideoWithURL(video!)
                        }
                    }
                }
            }
        default:
            break
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 파커 닫기
        dismiss(animated: true, completion: nil)
    }
    
}
