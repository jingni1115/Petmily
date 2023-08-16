//
//  MyPageViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit

class MyPageViewController: BaseViewController {
    let firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 8
        return stackView
    }()
    let menuBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    var profileImg: UIImageView = {
        let movieImg = UIImageView()
        movieImg.image = UIImage(systemName: "photo")
        movieImg.translatesAutoresizingMaskIntoConstraints = false
        movieImg.layer.cornerRadius = 50
        return movieImg
    }()
    var myName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var petName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let introFirstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let introSecondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var petComment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var petGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var petBirth: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var petBreed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dailyBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let infoBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
//    var myCollectionView = UICollectionView()
//    var myTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        setMenuBtn()
        setFisrtStackView()
        setProfileImg()
        setMyName()
        setPetName()
        setIntroFirstView()
        setIntroSecondView()
        setPetComment()
        setPetGender()
        setPetBirth()
        setPetBreed()
        setDailyBtn()
        setInfoBtn()
    }
    
    func setMenuBtn() {
        view.addSubview(menuBtn)
        menuBtn.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        NSLayoutConstraint.activate([
            menuBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            menuBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            menuBtn.widthAnchor.constraint(equalToConstant: 50),
            menuBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setFisrtStackView() {
        view.addSubview(firstStackView)
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            firstStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            firstStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            firstStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setProfileImg() {
        view.addSubview(profileImg)
        NSLayoutConstraint.activate([
            profileImg.topAnchor.constraint(equalTo: menuBtn.bottomAnchor),
            profileImg.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImg.heightAnchor.constraint(equalToConstant: 50),
            profileImg.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setMyName() {
        view.addSubview(myName)
        myName.text = "OO님의"
        myName.font = UIFont.systemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            myName.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 4),
            myName.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 16)
        ])
    }

    func setPetName() {
        view.addSubview(petName)
        petName.text = "동물이름"
        petName.font = UIFont.boldSystemFont(ofSize: 22)
        NSLayoutConstraint.activate([
            petName.topAnchor.constraint(equalTo: myName.bottomAnchor, constant: 4),
            petName.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 16)
        ])
    }
    
    func setIntroFirstView() {
        view.addSubview(introFirstView)
        introFirstView.backgroundColor = .systemGray4
        introFirstView.cornerRadius = 10
        NSLayoutConstraint.activate([
            introFirstView.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: 16),
            introFirstView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            introFirstView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            introFirstView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setPetComment() {
        introFirstView.addSubview(petComment)
        petComment.text = "\"안녕하세요 OO이네 강아지 OO입니다\""
        petComment.font = UIFont.systemFont(ofSize: 14)
        NSLayoutConstraint.activate([
            petComment.topAnchor.constraint(equalTo: introFirstView.safeAreaLayoutGuide.topAnchor, constant: 18),
            petComment.leadingAnchor.constraint(equalTo: introFirstView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            petComment.trailingAnchor.constraint(equalTo: introFirstView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            petComment.bottomAnchor.constraint(equalTo: introSecondView.topAnchor, constant: -12)
        ])
    }
    
    func setIntroSecondView() {
        introFirstView.addSubview(introSecondView)
        introSecondView.backgroundColor = .white
        introSecondView.cornerRadius = 10
        NSLayoutConstraint.activate([
            introSecondView.leadingAnchor.constraint(equalTo: introFirstView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            introSecondView.trailingAnchor.constraint(equalTo: introFirstView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            introSecondView.bottomAnchor.constraint(equalTo: introFirstView.safeAreaLayoutGuide.bottomAnchor, constant: -18)
        ])
    }
   

    func setPetGender() {
        introSecondView.addSubview(petGender)
        petGender.text = "성별: O"
        petGender.font = UIFont.systemFont(ofSize: 12)
        NSLayoutConstraint.activate([
            petGender.topAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.topAnchor),
            petGender.leadingAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.leadingAnchor),
//            petGender.trailingAnchor.constraint(equalTo: petBirth.leadingAnchor),
//            petGender.trailingAnchor.constraint(equalTo: petBreed.leadingAnchor),
            petGender.bottomAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    func setPetBirth() {
//        introSecondView.addSubview(petBirth)
//        petBirth.text = "생일: OOOO-OO-OO"
//        petBirth.font = UIFont.systemFont(ofSize: 12)
//        NSLayoutConstraint.activate([
//            petBirth.topAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.topAnchor),
//            petBirth.leadingAnchor.constraint(equalTo: petGender.trailingAnchor, constant: 4),
//            petBirth.trailingAnchor.constraint(equalTo: petBreed.leadingAnchor, constant: 4),
//            petBirth.bottomAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.bottomAnchor),
//        ])
    }
    
    func setPetBreed() {
        introSecondView.addSubview(petBreed)
        petBreed.text = "종: OOO"
        petBreed.font = UIFont.systemFont(ofSize: 12)
        NSLayoutConstraint.activate([
            petBreed.topAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.topAnchor),
//            petBreed.leadingAnchor.constraint(equalTo: petBirth.trailingAnchor),
            petBreed.leadingAnchor.constraint(equalTo: petGender.trailingAnchor),
            petBreed.trailingAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.trailingAnchor),
            petBreed.bottomAnchor.constraint(equalTo: introSecondView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setDailyBtn() {
        
    }
    
    func setInfoBtn() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
