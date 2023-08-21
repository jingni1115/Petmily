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
        stackView.spacing = 20
        return stackView
    }()

    var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var profileImg: UIImageView = {
        let Img = UIImageView()
        Img.translatesAutoresizingMaskIntoConstraints = false
        Img.layer.cornerRadius = 50
        return Img
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
    
    let firstSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let secondSpace: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
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
        stackView.distribution = .fillEqually
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
    var dailyData: [DailyModel]?
    var infoData: [InfoModel]?


    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoData()
        getDailyData()
//        configureView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        setMenuBtn()
//        setCollectionView()
//        setFirstStackView()
//    }
    
    func configureView() {

        
        setMenuBtn()
        
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
        setTableView()
        setCollectionView()
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
            self.infoData = result?.filter({ filt in
                filt.id == DataManager.sharedInstance.userInfo?.id ?? ""
            })
            CommonUtil.print(output: result)
            self.getProfileData()
//            self.tableView.reloadData()
        }
    }
    
    func getDailyData() {
        FirestoreService().getDailyData { result in
            self.dailyData = result?.filter({ filt in
                filt.id == DataManager.sharedInstance.userInfo?.id ?? ""
            })
            CommonUtil.print(output: result)
            self.getProfileData()
//            self.customCollectionView.reloadData()
        }
    }
    
    func setMenuBtn() {
        view.addSubview(menuBtn)
        menuBtn.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        NSLayoutConstraint.activate([
            menuBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            menuBtn.widthAnchor.constraint(equalToConstant: 50),
            menuBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setFirstStackView() {
//        contentScrollView.addSubview(firstStackView)
        view.addSubview(firstStackView)
        firstStackView.cornerRadius = 10
        
        firstStackView.addArrangedSubview(profileView)
        firstStackView.addArrangedSubview(secondStackView)
        firstStackView.addArrangedSubview(btnStackView)
        
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 16),
            firstStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//            firstStackView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
//            firstStackView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
        ])
    }
    
    func setProfileImg() {
        profileView.addSubview(profileImg)
//        profileImg.image = (dummyUserList[0].image != nil) ? dummyUserList[0].image : UIImage(named: "profile-placeholder")
        profileImg.image = UIImage(named: "profile-placeholder")
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
        
        secondStackView.layer.borderWidth = 1
        secondStackView.layer.borderColor = UIColor.clear.cgColor
        secondStackView.layer.masksToBounds = false
        secondStackView.layer.shadowColor = UIColor.darkGray.cgColor
        secondStackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        secondStackView.layer.shadowOpacity = 0.5
        secondStackView.layer.shadowRadius = 5.0
        
        secondStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        secondStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setPetComment() {
        secondStackView.addArrangedSubview(petComment)
        petComment.text = "\"안녕하세요 \(profileData?.name ?? "")네 강아지 \(profileData?.animalName ?? "")입니다\""
        petComment.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    @objc
    func updateProfile(_ gesture: UITapGestureRecognizer) {
        let vc = ProfileViewController()
        self.navigationPushController(viewController: vc, animated: false)
    }
    
    func setThirdStackView() {
        thirdStackView.cornerRadius = 10
        thirdStackView.isLayoutMarginsRelativeArrangement = true
        thirdStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        thirdStackView.backgroundColor = .white
        
        thirdStackView.addArrangedSubview(petGender)
        thirdStackView.addArrangedSubview(firstSpace)
        thirdStackView.addArrangedSubview(petBirth)
        thirdStackView.addArrangedSubview(secondSpace)
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
        btnStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        btnStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setDailyBtn() {
        dailyBtn.addTarget(self, action: #selector(setDailybtn), for: .touchUpInside)
        dailyBtn.backgroundColor = .systemGray
        
//        dailyBtn.layer.borderWidth = 1
//        dailyBtn.layer.borderColor = UIColor.clear.cgColor
//        dailyBtn.layer.masksToBounds = false
//        dailyBtn.layer.shadowColor = UIColor.darkGray.cgColor
//        dailyBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
//        dailyBtn.layer.shadowOpacity = 1
//        dailyBtn.layer.shadowRadius = 5.0
    }
        
    func setInfoBtn() {
        infoBtn.addTarget(self, action: #selector(setInfobtn), for: .touchUpInside)
        infoBtn.backgroundColor = .systemGray3
        
//        infoBtn.layer.borderWidth = 1
//        infoBtn.layer.borderColor = UIColor.clear.cgColor
//        infoBtn.layer.masksToBounds = false
//        infoBtn.layer.shadowColor = UIColor.darkGray.cgColor
//        infoBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
//        infoBtn.layer.shadowOpacity = 1
//        infoBtn.layer.shadowRadius = 5.0
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
        firstStackView.addArrangedSubview(tableView)
    }
    
    func setCollectionView() {
        customCollectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        customCollectionView.register(MyPageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MyPageCollectionViewCell")
        
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.addArrangedSubview(customCollectionView)
//        customCollectionView.topAnchor.constraint(equalTo: btnStackView.bottomAnchor).isActive = true
//        customCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        customCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        customCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 해제
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택한 정보 가져오기
        let selectedInfo = infoData?[indexPath.row]
        let selectedUser = profileData
        
        
        // 목표 뷰 컨트롤러 초기화
        let vc = InfoDetailViewController.init(nibName: "InfoDetailViewController", bundle: nil)
        vc.selectedInfo = selectedInfo // 정보 전달
        vc.selectedUser = selectedUser // 유저 정보
        navigationPushController(viewController: vc, animated: true)
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let itemSpacing: CGFloat = 10
        let cellWidth: CGFloat = (width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3
        let cellHeigt: CGFloat = (width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3
//        let cellWidth: CGFloat = width / 3
//        let cellHeigt: CGFloat = width / 3
        return CGSize(width: cellWidth, height: cellHeigt)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCollectionViewCell", for: indexPath) as! MyPageCollectionViewCell
        FirebaseStorageManager.downloadImage(urlString: "gs://petmily-6b63f.appspot.com/DF52E2BD-8489-43F8-824B-C4F4D42B715A1692579160.0970469", completion: { result in
            cell.collectionViewImage.image = result
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀 선택 해제
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // 선택한 정보 가져오기
        let selectedInfo = dailyData?[indexPath.row]
        let selectedUser = profileData
        
        // 목표 뷰 컨트롤러 초기화
//        let vc = InfoDetailViewController.init(nibName: "InfoDetailViewController", bundle: nil)
//        vc.selectedInfo = selectedInfo // 정보 전달
//        vc.selectedUser = selectedUser // 유저 정보
//        navigationPushController(viewController: vc, animated: true)
    }
}

