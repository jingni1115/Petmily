//
//  MyPageViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let dummyList = [UIImage(systemName: "pencil"),UIImage(systemName: "pencil"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo"),UIImage(systemName: "photo")]
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
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
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.backgroundColor = .black
        return stackView
    }()
    
    var petView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var petComment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        setMenuBtn()
        setScrollView()
        
        setFirstStackView()
        setProfileView()
        setProfileImg()
        setMyName()
        setPetName()
        setPetComment()
        
        setPetView()
        setSecondStackView()
        setPetGender()
        setPetBirth()
        setPetBreed()
        
        setBtnStackView()
        setDailyBtn()
        setInfoBtn()
        setTableView()
    }
    
    func setMenuBtn() {
        view.addSubview(menuBtn)
        menuBtn.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        NSLayoutConstraint.activate([
            menuBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            menuBtn.widthAnchor.constraint(equalToConstant: 50),
            menuBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setScrollView() {
        view.addSubview(contentScrollView)
        contentScrollView.backgroundColor = .cyan
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 16),
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setFirstStackView() {
        contentScrollView.addSubview(firstStackView)
        firstStackView.backgroundColor = .systemGray4
        firstStackView.cornerRadius = 10
        
        firstStackView.addArrangedSubview(profileView)
        firstStackView.addArrangedSubview(petView)
        firstStackView.addArrangedSubview(btnStackView)
        firstStackView.addArrangedSubview(tableView)
        firstStackView.addArrangedSubview(collectionView)
        firstStackView.addArrangedSubview(myName)
        
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            firstStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            firstStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            firstStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            firstStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
        ])
    }
    
    func setProfileView() {
        profileView.backgroundColor = .yellow
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
        myName.text = "OO님의"
        myName.font = UIFont.systemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            myName.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 4),
            myName.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 16)
        ])
    }
    
    func setPetName() {
        profileView.addSubview(petName)
        petName.text = "동물이름"
        petName.font = UIFont.boldSystemFont(ofSize: 22)
        NSLayoutConstraint.activate([
            petName.topAnchor.constraint(equalTo: myName.bottomAnchor, constant: 4),
            petName.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 16)
        ])
    }
    
    func setPetComment() {
        petComment.text = "\"안녕하세요 OO이네 강아지 OO입니다\""
        petComment.font = UIFont.systemFont(ofSize: 14)
    }
    
    func setPetView() {
        petView.addSubview(secondStackView)
        petView.backgroundColor = .purple
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(updateProfile(_:)))
        petView.addGestureRecognizer(tapGesture)
        petView.isUserInteractionEnabled = true
    }
    
    @objc
    func updateProfile(_ gesture: UITapGestureRecognizer) {
        let vc = ProfileViewController.init(nibName: "ProfileViewController", bundle: nil)
              navigationPushController(viewController: vc, animated: true)
        self.present(ProfileViewController(), animated: true)
    }
    
    func setSecondStackView() {
        secondStackView.backgroundColor = .white
        secondStackView.cornerRadius = 10
        secondStackView.isLayoutMarginsRelativeArrangement = true
        secondStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        secondStackView.addArrangedSubview(petGender)
        secondStackView.addArrangedSubview(petBirth)
        secondStackView.addArrangedSubview(petBreed)
        
        NSLayoutConstraint.activate([
            secondStackView.topAnchor.constraint(equalTo: petView.safeAreaLayoutGuide.topAnchor, constant: 12),
            secondStackView.leadingAnchor.constraint(equalTo: petView.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            secondStackView.trailingAnchor.constraint(equalTo: petView.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            secondStackView.bottomAnchor.constraint(equalTo: petView.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    func setPetGender() {
        petGender.text = "성별: O"
        petGender.font = UIFont.systemFont(ofSize: 12)
        petGender.backgroundColor = .brown
    }
    
    func setPetBirth() {
        petBirth.text = "생일: OOOO-OO-OO"
        petBirth.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setPetBreed() {
        petBreed.text = "종: OOO"
        petBreed.font = UIFont.systemFont(ofSize: 12)
    }
    
    func setBtnStackView() {
        btnStackView.addArrangedSubview(dailyBtn)
        btnStackView.addArrangedSubview(infoBtn)
        
        btnStackView.backgroundColor = .yellow
        dailyBtn.backgroundColor = .blue
        infoBtn.backgroundColor = .red
    }
    
    func setDailyBtn() {
        dailyBtn.addTarget(self, action: #selector(setDailybtn), for: .touchUpInside)
    }
        
    func setInfoBtn() {
        infoBtn.addTarget(self, action: #selector(setInfobtn), for: .touchUpInside)
    }
    
    @objc
    func setDailybtn() {
        tableView.isHidden = !isHidden
        collectionView.isHidden = isHidden
        print("table: \(tableView.isHidden)")
        print("collection: \(collectionView.isHidden)")
    }
    
    @objc
    func setInfobtn() {
        tableView.isHidden = isHidden
        collectionView.isHidden = !isHidden
        print("table: \(tableView.isHidden)")
        print("collection: \(collectionView.isHidden)")
    }
    
    func setTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .brown
        tableView.isHidden = true
        tableView.bounds.size.height = 100
    }
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//
//        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width), height: (UIScreen.main.bounds.width))
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        
        collectionView.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemPink
//        collectionView.bounds.size.height = 100
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: firstStackView.bottomAnchor)
        ])
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        return dummyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! MyPageCollectionViewCell
        cell.collectionViewImage.image = dummyList[indexPath.row]
        return cell
    }
}
