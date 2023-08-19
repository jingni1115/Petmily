//
//  MyPageViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit

class MyPageViewController: BaseViewController {
    private var customCollectionView: CustomCollectionView!
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let dummyList = [UIImage(systemName: "pencil"),UIImage(systemName: "pencil"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo")]
    
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
    
    let firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.cornerRadius = 5
        return stackView
    }()

    var petComment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
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

    let btnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
//        stackView.alignment = .fill
        stackView.distribution = .fillEqually
//        stackView.spacing = 2
        return stackView
    }()
    
    var isHidden = false

    let dailyBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("데일리", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()

    let infoBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("정보", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var profileData: UserModel?
    var infoData: [InfoModel]?


    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileData()
    }
    
    func configureView() {
        setTableView()
        setCollectionView()
        
        setMenuBtn()
        setScrollView()
        
        setFirstStackView()
        setProfileImg()
        setMyName()
        setPetName()
        
        setPetComment()
        setSecondStackView()
        setThirdStackView()
        setPetGender()
        setPetBirth()
        setPetBreed()
        
        setBtnStackView()
        setDailyBtn()
        setInfoBtn()
    }
    
    func getProfileData() {
        FirestoreService().getUserData { result in
            self.profileData = result
            print(self.profileData)
            self.configureView()
        }
    }
    
    func getInfoData() {
        FirestoreService().getInfoData { result in
            self.infoData = result
            CommonUtil.print(output: result)
            self.tableView.reloadData()
        }
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
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setFirstStackView() {
        contentScrollView.addSubview(firstStackView)
        firstStackView.cornerRadius = 10
        
        firstStackView.addArrangedSubview(profileView)
        firstStackView.addArrangedSubview(secondStackView)
        firstStackView.addArrangedSubview(btnStackView)
        firstStackView.addArrangedSubview(tableView)
        firstStackView.addArrangedSubview(customCollectionView)
        
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            firstStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            firstStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            firstStackView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            firstStackView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
        ])
    }
    
    func setProfileImg() {
        profileView.addSubview(profileImg)
        NSLayoutConstraint.activate([
            profileImg.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 4),
            profileImg.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            profileImg.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -4),
            profileImg.heightAnchor.constraint(equalToConstant: 50),
            profileImg.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setMyName() {
        profileView.addSubview(myName)
        myName.text = "\(profileData?.name ?? "")님의"
        myName.font = UIFont.systemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            myName.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 4),
            myName.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 16)
        ])
    }
    
    func setPetName() {
        profileView.addSubview(petName)
        petName.text = profileData?.animalName ?? ""
        petName.font = UIFont.boldSystemFont(ofSize: 22)
        NSLayoutConstraint.activate([
            petName.topAnchor.constraint(equalTo: myName.bottomAnchor, constant: 4),
            petName.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 16)
        ])
    }
    
    func setSecondStackView() {
        secondStackView.addArrangedSubview(thirdStackView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(updateProfile(_:)))
        secondStackView.addGestureRecognizer(tapGesture)
        secondStackView.isUserInteractionEnabled = true
        secondStackView.backgroundColor = .systemGray3
        secondStackView.isLayoutMarginsRelativeArrangement = true
        secondStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func setPetComment() {
        secondStackView.addArrangedSubview(petComment)
        petComment.text = "\"안녕하세요 \(profileData?.name ?? "")네 강아지 \(profileData?.animalName ?? "")입니다\""
        petComment.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    @objc
    func updateProfile(_ gesture: UITapGestureRecognizer) {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setThirdStackView() {
        thirdStackView.cornerRadius = 10
        thirdStackView.isLayoutMarginsRelativeArrangement = true
        thirdStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        thirdStackView.backgroundColor = .white
        
        thirdStackView.addArrangedSubview(petGender)
        thirdStackView.addArrangedSubview(petBirth)
        thirdStackView.addArrangedSubview(petBreed)
        
        NSLayoutConstraint.activate([
            thirdStackView.leadingAnchor.constraint(equalTo: secondStackView.leadingAnchor, constant: 20),
            thirdStackView.trailingAnchor.constraint(equalTo: secondStackView.trailingAnchor, constant: -20)
        ])
    }
    
    func setPetGender() {
        petGender.text = "성별: \(profileData?.gender ?? "")"
        petGender.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setPetBirth() {
        petBirth.text = "생일: \(profileData?.birth ?? "")"
        petBirth.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setPetBreed() {
        petBreed.text = "종: \(profileData?.type ?? "")"
        petBreed.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setBtnStackView() {
        btnStackView.addArrangedSubview(dailyBtn)
        btnStackView.addArrangedSubview(infoBtn)
    }
    
    func setDailyBtn() {
        dailyBtn.addTarget(self, action: #selector(setDailybtn), for: .touchUpInside)
        dailyBtn.backgroundColor = .systemGray
    }
        
    func setInfoBtn() {
        infoBtn.addTarget(self, action: #selector(setInfobtn), for: .touchUpInside)
        infoBtn.backgroundColor = .systemGray3
    }
    
    @objc
    func setDailybtn() {
        tableView.isHidden = !isHidden
        customCollectionView.isHidden = isHidden
        dailyBtn.backgroundColor = .systemGray
        infoBtn.backgroundColor = .systemGray3
        print("table: \(tableView.isHidden)")
        print("collection: \(customCollectionView.isHidden)")
    }
    
    @objc
    func setInfobtn() {
        tableView.isHidden = isHidden
        customCollectionView.isHidden = !isHidden
        dailyBtn.backgroundColor = .systemGray3
        infoBtn.backgroundColor = .systemGray
        print("table: \(tableView.isHidden)")
        print("collection: \(customCollectionView.isHidden)")
    }
    
    func setTableView() {
        let nibName = UINib(nibName: "InfoTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "InfoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
    }
    
    func setCollectionView() {
        customCollectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        customCollectionView.register(MyPageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MyPageCollectionViewCell")
        
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        cell.tagLabel.isHidden = true
        cell.userTimeLabel.isHidden = true
//        cell.imageLabel.image = InfoList.list[indexPath.row].images?[0]
        cell.titleLabel.text = infoData?[indexPath.row].title
        cell.descriptionLabel.text = infoData?[indexPath.row].content
        return cell
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let itemSpacing: CGFloat = 10
        let cellWidth: CGFloat = (width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3
        let cellHeigt: CGFloat = ((width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3)
        return CGSize(width: cellWidth, height: cellHeigt)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCollectionViewCell", for: indexPath) as! MyPageCollectionViewCell
//        cell.collectionViewImage.image = InfoList.list[indexPath.row].images?[0]
        return cell
    }
}

