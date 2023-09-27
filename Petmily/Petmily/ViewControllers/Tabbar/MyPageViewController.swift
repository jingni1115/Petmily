//
//  MyPageViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import SnapKit
import SwiftUI
import UIKit

class MyPageViewController: BaseViewController {
    var settingButton: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        return btn
    }()
    
    var userNameLabel: UILabel = {
        var label = UILabel()
        label.text = "단지"
        label.textColor = .white
        label.font = Font.myPageTitleFont
        return label
    }()
    
    var editProfileButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("기본 정보 수정하기", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = Font.myPageLabelFont
        btn.backgroundColor = .systemGray5
        btn.cornerRadius = 10
        return btn
    }()
    
    var profileImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "photo")
        view.bounds.size.width = 60
        view.bounds.size.height = 60
        view.cornerRadius = view.bounds.width / 2
        view.clipsToBounds = true
        return view
    }()
    
    lazy var petInfoStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [petAgeView, petGenderView, petBreedView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    var petAgeView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var petAgeLabel: UILabel = {
        var view = UILabel()
        view.text = "나이"
        view.font = Font.myPageLabelFont
        view.textColor = .white
        return view
    }()
    
    var petAgeText: UILabel = {
        var view = UILabel()
        view.text = "7살"
        view.font = Font.myPageTitleFont
        view.textColor = .white
        return view
    }()
    
    var petGenderView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var petGenderLabel: UILabel = {
        var view = UILabel()
        view.text = "성별"
        view.font = Font.myPageLabelFont
        view.textColor = .white
        return view
    }()
    
    var petGenderText: UILabel = {
        var view = UILabel()
        view.text = "몰라"
        view.font = Font.myPageTitleFont
        view.textColor = .white
        return view
    }()
    
    var petBreedView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var petBreedLabel: UILabel = {
        var view = UILabel()
        view.text = "종"
        view.font = Font.myPageLabelFont
        view.textColor = .white
        return view
    }()
    
    var petBreedText: UILabel = {
        var view = UILabel()
        view.text = "강아지"
        view.font = Font.myPageTitleFont
        view.textColor = .white
        return view
    }()
    
    var postView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return view
    }()
    
    var postSegmentControl: UISegmentedControl = {
        var control = UISegmentedControl(items: ["데일리", "정보공유"])
        control.selectedSegmentTintColor = .gray
        control.backgroundColor = .white
        control.selectedSegmentIndex = 0
        return control
    }()
    
    var shouldHideFirstView: Bool? {
       didSet {
         guard let shouldHideFirstView = self.shouldHideFirstView else { return }
         self.dailyCollectionView.isHidden = shouldHideFirstView
         self.infoTableView.isHidden = !self.dailyCollectionView.isHidden
       }
     }
    
    lazy var postStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [dailyCollectionView, infoTableView])
        stackView.axis = .horizontal
        return stackView
    }()
    
    let dailyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let rowCount: CGFloat = 3
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / rowCount) - 8, height: (UIScreen.main.bounds.width / rowCount) - 4)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        return collectionView
    }()
    
    var infoTableView: UITableView = {
        var view = UITableView()
        view.backgroundColor = .purple
        return view
    }()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var profileData: UserModel?
    var dailyData: [DailyModel]?
    var infoData: [InfoModel]?
    var dailyThumbnail: UIImage?
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getDailyData()
    }
    
    func getProfileData() {
        FirestoreService().getUserData { result in
            self.profileData = result
            self.getInfoData()
        }
    }
    
    func getInfoData() {
        FirestoreService().getInfoData { result in
            self.infoData = result?.filter({ filt in
                filt.id == DataManager.sharedInstance.userInfo?.id ?? ""
            })
            CommonUtil.print(output: result)
            self.configureView()
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
    
    func configureView() {
        view.backgroundColor = .systemPink
        dailyCollectionView.register(MyPageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MyPageCollectionViewCell")
        
        configureUI()
        
        setCollectionView()
        setTableView()
        setSegmentedControl()
    }
    
    func configureUI() {
        // add
        view.addSubview(settingButton)
        
        view.addSubview(userNameLabel)
        view.addSubview(editProfileButton)
        view.addSubview(profileImage)
        
        view.addSubview(petInfoStackView)
        petAgeView.addSubview(petAgeLabel)
        petAgeView.addSubview(petAgeText)
        petGenderView.addSubview(petGenderLabel)
        petGenderView.addSubview(petGenderText)
        petBreedView.addSubview(petBreedLabel)
        petBreedView.addSubview(petBreedText)
        
        view.addSubview(postView)
        postView.addSubview(postSegmentControl)
        postView.addSubview(postStackView)
        
        // constraints
        settingButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        userNameLabel.snp.makeConstraints{
            $0.top.equalTo(settingButton.snp.bottom).inset(-10)
            // view?
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        editProfileButton.snp.makeConstraints{
            $0.top.equalTo(userNameLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
        
        profileImage.snp.makeConstraints{
            $0.top.equalTo(settingButton.snp.bottom).inset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(editProfileButton)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        
        petInfoStackView.snp.makeConstraints{
            $0.top.equalTo(editProfileButton.snp.bottom).inset(-10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        petAgeLabel.snp.makeConstraints{
            $0.top.equalTo(petAgeView).inset(10)
            $0.leading.equalTo(petAgeView).inset(10)
            $0.bottom.equalTo(petAgeView).inset(10)
        }
        
        petAgeText.snp.makeConstraints{
            $0.top.equalTo(petAgeView).inset(10)
            $0.trailing.equalTo(petAgeView).inset(10)
            $0.bottom.equalTo(petAgeView).inset(10)
        }
        
        petGenderLabel.snp.makeConstraints{
            $0.top.equalTo(petGenderView).inset(10)
            $0.leading.equalTo(petGenderView).inset(10)
            $0.bottom.equalTo(petGenderView).inset(10)
        }
        
        petGenderText.snp.makeConstraints{
            $0.top.equalTo(petGenderView).inset(10)
            $0.trailing.equalTo(petGenderView).inset(10)
            $0.bottom.equalTo(petGenderView).inset(10)
        }
        
        petBreedLabel.snp.makeConstraints{
            $0.top.equalTo(petBreedView).inset(10)
            $0.leading.equalTo(petBreedView).inset(10)
            $0.bottom.equalTo(petBreedView).inset(10)
        }
        
        petBreedText.snp.makeConstraints{
            $0.top.equalTo(petBreedView).inset(10)
            $0.trailing.equalTo(petBreedView).inset(10)
            $0.bottom.equalTo(petBreedView).inset(10)
        }
        
        postView.snp.makeConstraints{
            $0.top.equalTo(petInfoStackView.snp.bottom).inset(-10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        postSegmentControl.snp.makeConstraints{
            $0.top.equalTo(postView)
            $0.leading.equalTo(postView)
            $0.trailing.equalTo(postView)
            $0.height.equalTo(60)
        }
        
        postStackView.snp.makeConstraints{
            $0.top.equalTo(postSegmentControl.snp.bottom)
            $0.leading.equalTo(postView)
            $0.trailing.equalTo(postView)
            $0.bottom.equalTo(postView)
        }
    }
    
    func setSettingButton() {
        // click event
    }
    
    func setUserNameLabel() {
        // mapping
    }
    
    func setEditProfile() {
        // click event
    }
    
    func setProfileImage() {
        // mapping
    }
    
    func setPetAge() {
        // mapping
    }
    
    func setPetGender() {
        // mapping
    }
    
    func setPetBreed() {
        // mapping
    }

    func setSegmentedControl() {
        // click event
        postSegmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        postSegmentControl.selectedSegmentIndex = 0
        didChangeValue(segment: postSegmentControl)
    }
    
    func setCollectionView() {
        dailyCollectionView.delegate = self
        dailyCollectionView.dataSource = self

    }
    
    func setTableView() {
        infoTableView.isHidden = true
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
       self.shouldHideFirstView = segment.selectedSegmentIndex != 0
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyCollectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCollectionViewCell", for: indexPath) as! MyPageCollectionViewCell
        FirebaseStorageManager.downloadImage(urlString: "gs://petmily-6b63f.appspot.com/DF52E2BD-8489-43F8-824B-C4F4D42B715A1692579160.0970469", completion: { result in
            cell.collectionViewImage.image = result
        })
        return cell
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//// SwiftUI를 활용한 미리보기
//struct MyPageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPageVCReprsentable().edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct MyPageVCReprsentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        let MyPageVC = MyPageViewController()
//        return UINavigationController(rootViewController: MyPageVC)
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//    typealias UIViewControllerType = UIViewController
//}
