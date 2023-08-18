//
//  ProfileViewController.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/08/16.
//

import UIKit

class ProfileViewController: BaseViewController {

    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let menuBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "photo")
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
        return label
    }()
    
    let petNameTextField: UITextField = {
        let tField = UITextField()
//        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let myNameLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주인 이름"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let myNameTextField: UITextField = {
        let tField = UITextField()
//        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "성별"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let genderStackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
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
        return label
    }()
    
    let birthTextField: UITextField = {
        let tField = UITextField()
//        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let breedLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "종"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let breedTextField: UITextField = {
        let tField = UITextField()
//        tField.translatesAutoresizingMaskIntoConstraints = false
        tField.layer.cornerRadius = 5
        tField.layer.borderWidth = 1
        tField.layer.borderColor = UIColor.gray.cgColor
        return tField
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "자기 소개"
        label.font = UIFont.systemFont(ofSize: 14)
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
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.cornerRadius = 20
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    func configureView() {
        setMenuBtn()
        
        setScrollView()
        setStackView()
        setGenderStackView()
        setFirstGenderBtn()
        setSecondGenderBtn()
    }
    
    func setMenuBtn() {
        view.addSubview(menuBtn)
        menuBtn.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        NSLayoutConstraint.activate([
            menuBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            menuBtn.widthAnchor.constraint(equalToConstant: 50),
            menuBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setScrollView() {
        view.addSubview(contentScrollView)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 16),
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
            stackView.heightAnchor.constraint(greaterThanOrEqualTo: contentScrollView.heightAnchor),
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: contentScrollView.widthAnchor)
        ])
    }
    
    func setGenderStackView() {
        genderStackView.addArrangedSubview(firstGenderBtn)
        genderStackView.addArrangedSubview(secondGenderBtn)
    }
    
    func setFirstGenderBtn() {
        firstGenderBtn.addTarget(self, action: #selector(clickedFirstGender), for: .touchUpInside)
    }
    
    func setSecondGenderBtn() {
        secondGenderBtn.addTarget(self, action: #selector(clickedSecondGender), for: .touchUpInside)
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
}
