//
//  ProfileViewController.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/08/16.
//

import AVFoundation
import Photos
import SnapKit
import SwiftUI
import UIKit

class ProfileViewController: BaseHeaderViewController {
    
    let photo = UIImagePickerController() // 앨범
    
    let datePicker = UIDatePicker()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profile-placeholder")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let myNickName: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 152, height: 30))
        tf.placeholder = "닉네임을 입력해주세요"
        let bottomLineView = UIView(frame: CGRect(x: 0, y: tf.frame.size.height + 23, width: tf.frame.size.width, height: 1.0))
        bottomLineView.backgroundColor = UIColor.gray
        tf.addSubview(bottomLineView)
        return tf
    }()
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "동물 이름"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let petNameTextField: UITextField = {
        let tField = UITextField()
        tField.text = DataManager.sharedInstance.userInfo?.animalName ?? ""
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let myNameLabel: UILabel = {
        let label = UILabel()
        label.text = "주인 이름"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let myNameTextField: UITextField = {
        let tField = UITextField()
        tField.text = DataManager.sharedInstance.userInfo?.name ?? ""
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stackView
    }()
    
    let firstGenderBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGray
        btn.setTitle("남", for: .normal)
        btn.cornerRadius = 5
        return btn
    }()
    
    let secondGenderBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGray3
        btn.setTitle("여", for: .normal)
        btn.cornerRadius = 5
        return btn
    }()
    
    let birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let birthTextField: UITextField = {
        let tField = UITextField()
        tField.text = DataManager.sharedInstance.userInfo?.birth ?? ""
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let breedLabel: UILabel = {
        let label = UILabel()
        label.text = "종"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let breedTextField: UITextField = {
        let tField = UITextField()
        tField.text = DataManager.sharedInstance.userInfo?.type ?? ""
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "자기 소개"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let commentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 5
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.gray.cgColor
        return tv
    }()
    
    let completeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("확인", for: .normal)
        btn.backgroundColor = .darkGray
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.cornerRadius = 20
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photo.delegate = self
        
        setHeaderTitleName(title: "프로필")
        configureUI()
    }
    

    
    func configureUI() {
        setupUI()
        setProfileImage()
        setGenderStackView()
        setFirstGenderBtn()
        setSecondGenderBtn()
        setDatePicker()
        setDateToolBar()
        
        setCompleteBtn()
    }
    
    func setupUI() {
        view.addSubview(contentScrollView)
        view.addSubview(profileImage)
        view.addSubview(myNickName)
        contentScrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(petNameLabel)
        stackView.addArrangedSubview(petNameTextField)
        
        stackView.addArrangedSubview(myNameLabel)
        stackView.addArrangedSubview(myNameTextField)
        
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(genderStackView)
        
        stackView.addArrangedSubview(birthLabel)
        stackView.addArrangedSubview(birthTextField)
        
        stackView.addArrangedSubview(breedLabel)
        stackView.addArrangedSubview(breedTextField)
        
        stackView.addArrangedSubview(commentLabel)
        stackView.addArrangedSubview(commentTextView)
        
        stackView.addArrangedSubview(completeBtn)
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10 + 49)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(100)
        }
        
        myNickName.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).inset(5)
            $0.centerX.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(myNickName.snp.bottom).inset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        // TODO: stackView Constraints
        stackView.snp.makeConstraints {
            $0.top.equalTo(myNickName.snp.bottom).inset(-10)
            $0.leading.trailing.bottom.equalTo(contentScrollView).inset(10)
        }
        
        petNameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        petNameTextField.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        myNameLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        myNameTextField.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        genderLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        birthLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        birthTextField.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        breedLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        breedTextField.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        commentLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        commentTextView.snp.makeConstraints {
            $0.height.equalTo(400)
        }
        
        completeBtn.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
    
    func setProfileImage() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageViewTapped(_ sender: AnyObject) {
        selectImage()
    }
    
    func selectImage(){
            DispatchQueue.main.async {
                self.photo.sourceType = .photoLibrary // 앨범 지정 실시
                self.photo.allowsEditing = true // 편집을 허용하지 않음
                self.present(self.photo, animated: false, completion: nil)
            }
        }
    
    func setGenderStackView() {
        genderStackView.addArrangedSubview(firstGenderBtn)
        genderStackView.addArrangedSubview(secondGenderBtn)
    }
    
    func setFirstGenderBtn() {
        firstGenderBtn.addTarget(self, action: #selector(clickedFirstGender), for: .touchUpInside)
        
        firstGenderBtn.layer.borderWidth = 1
        firstGenderBtn.layer.borderColor = UIColor.clear.cgColor
        firstGenderBtn.layer.masksToBounds = false
        firstGenderBtn.layer.shadowColor = UIColor.darkGray.cgColor
        firstGenderBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        firstGenderBtn.layer.shadowOpacity = 1
        firstGenderBtn.layer.shadowRadius = 5.0
    }
    
    func setSecondGenderBtn() {
        secondGenderBtn.addTarget(self, action: #selector(clickedSecondGender), for: .touchUpInside)
        
        secondGenderBtn.layer.borderWidth = 1
        secondGenderBtn.layer.borderColor = UIColor.clear.cgColor
        secondGenderBtn.layer.masksToBounds = false
        secondGenderBtn.layer.shadowColor = UIColor.darkGray.cgColor
        secondGenderBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        secondGenderBtn.layer.shadowOpacity = 1
        secondGenderBtn.layer.shadowRadius = 5.0
    }
    
    @objc
    func clickedFirstGender() {
        firstGenderBtn.backgroundColor = .systemGray
        secondGenderBtn.backgroundColor = .systemGray3
    }
    
    @objc
    func clickedSecondGender() {
        firstGenderBtn.backgroundColor = .systemGray3
        secondGenderBtn.backgroundColor = .systemGray
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        birthTextField.inputView = datePicker
        birthTextField.text = dateFormat(date: Date())
        birthTextField.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let img = UIImage(systemName: "calendar")
        imgView.image = img
        birthTextField.rightView = imgView
    }
    
    @objc func changeDate(_ sender: UIDatePicker) {
        birthTextField.text = dateFormat(date: sender.date)
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        return formatter.string(from: date)
    }
    
    func setDateToolBar() {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        birthTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        birthTextField.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        birthTextField.resignFirstResponder()
    }
    
    func setCompleteBtn() {
        completeBtn.addTarget(self, action: #selector(clickCompleteBtn), for: .touchUpInside)
    }
    
    @objc func clickCompleteBtn() {
        if petNameTextField.text ?? "" == "" {
            CommonUtil().showOneButtonAlertView(title: "동물 이름", message: "작성이 필요합니다.")
        }
        if myNameTextField.text ?? "" == "" {
            CommonUtil().showOneButtonAlertView(title: "주인 이름", message: "작성이 필요합니다.")
        }
        if birthTextField.text ?? "" == "" {
            CommonUtil().showOneButtonAlertView(title: "생년 월일", message: "작성이 필요합니다.")
        }
        if breedTextField.text ?? "" == "" {
            CommonUtil().showOneButtonAlertView(title: "종", message: "작성이 필요합니다.")
        }
        
        FirestoreService().editUserData(name: myNameTextField.text ?? "", animalName: petNameTextField.text ?? "", birth: birthTextField.text ?? "", gender: "여자", imageURL: "", type: breedTextField.text ?? "") { result in
            self.navigationPopViewController(animated: false) {
            }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage]{
            // 이미지 뷰에 앨범에서 선택한 사진 표시
            CommonUtil.print(output: img)
            self.profileImage.image = img as? UIImage
        }
        // 이미지 파커 닫기
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 파커 닫기
        self.dismiss(animated: true, completion: nil)
    }
}

// SwiftUI를 활용한 미리보기
struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct ProfileVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let ProfileVC = ProfileViewController()
        return UINavigationController(rootViewController: ProfileVC)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    typealias UIViewControllerType = UIViewController
}
