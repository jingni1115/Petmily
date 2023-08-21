//
//  ProfileViewController.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/08/16.
//

import AVFoundation
import Photos
import UIKit

class ProfileViewController: BaseHeaderViewController {
    
    let photo = UIImagePickerController() // 앨범
    
    let datePicker = UIDatePicker()
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        //        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "profile-placeholder")
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        //        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "동물 이름"
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    let petNameTextField: UITextField = {
        let tField = UITextField()
        //        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        tField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return tField
    }()
    
    let myNameLabel: UILabel = {
        let label = UILabel()
        //        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주인 이름"
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    let myNameTextField: UITextField = {
        let tField = UITextField()
        //        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        tField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return tField
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        //        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "성별"
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    let genderStackView: UIStackView = {
        let stackView = UIStackView()
        //        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stackView
    }()
    
    let firstGenderBtn: UIButton = {
        let btn = UIButton()
        //        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray
        btn.setTitle("남", for: .normal)
        btn.cornerRadius = 5
        return btn
    }()
    
    let secondGenderBtn: UIButton = {
        let btn = UIButton()
        //        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray3
        btn.setTitle("여", for: .normal)
        btn.cornerRadius = 5
        return btn
    }()
    
    let birthLabel: UILabel = {
        let label = UILabel()
        //        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "생년월일"
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    let birthTextField: UITextField = {
        let tField = UITextField()
        //        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        tField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return tField
    }()
    
    let breedLabel: UILabel = {
        let label = UILabel()
        //        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "종"
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    let breedTextField: UITextField = {
        let tField = UITextField()
        //        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        tField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return tField
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        //        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "자기 소개"
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    let commentTextView: UITextView = {
        let tv = UITextView()
        //        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 5
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return tv
    }()
    
    let completeBtn: UIButton = {
        let btn = UIButton()
        //        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("확인", for: .normal)
        btn.backgroundColor = .darkGray
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.cornerRadius = 20
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photo.delegate = self
        
        setHeaderTitleName(title: "프로필")
        configureView()
    }
    

    
    func configureView() {
        setScrollView()
        setStackView()
        
        setProfileImage()
        setGenderStackView()
        setFirstGenderBtn()
        setSecondGenderBtn()
        setDatePicker()
        setDateToolBar()
        
        setCompleteBtn()
    }
    
    func setScrollView() {
        view.addSubview(contentScrollView)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 49),
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setStackView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(profileImage)
        
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
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            stackView.heightAnchor.constraint(greaterThanOrEqualTo: contentScrollView.heightAnchor)
            //            stackView.widthAnchor.constraint(greaterThanOrEqualTo: contentScrollView.widthAnchor)
        ])
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
        FirestoreService().editUserData(name: myNameTextField.text ?? "", animalName: petNameTextField.text ?? "", birth: birthTextField.text ?? "", gender: "여자", imageURL: "", type: breedTextField.text ?? "") { result in
            self.navigationPopViewController(animated: false) {
    //            CommonUtil.print(output: vc.dummyUserList[0].name)
            }
        }
//        let vc = MyPageViewController()
//        vc.dummyUserList[0] = User(name: myNameTextField.text ?? "")
        
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
