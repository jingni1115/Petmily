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
    lazy var myPageProfileView = MyPageProfileView()
    
    lazy var myPagePostView: MyPagePostView = {
        let view = MyPagePostView()
        view.dailyCollectionView.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCollectionViewCell.identifier)
        view.infoCollectionView.register(ShareInfoViewCell.self, forCellWithReuseIdentifier: ShareInfoViewCell.identifier)
        return view
    }()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var profileList = ["1번", "2번"]
    var profileData: UserModel?
    var dailyData: [DailyModel]?
    var infoData: [InfoModel]?
    var dailyThumbnail: UIImage?
    
    // dummy
    let dailyDummy = [UIImage(named: "danjy"), UIImage(named: "chichi"), UIImage(named: "danjy"), UIImage(named: "chichi"), UIImage(named: "danjy"), UIImage(named: "chichi"), UIImage(named: "danjy"), UIImage(named: "chichi"), UIImage(named: "danjy"), UIImage(named: "chichi"), UIImage(named: "danjy"), UIImage(named: "chichi"), UIImage(named: "danjy"), UIImage(named: "chichi")]
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "myPageBackground")
        return view
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        getDailyData()
        
        setupUI()
        setCollectionView()
        setSegmentedControl()
        
        myPageProfileView.profileTextField.delegate = self
        myPageProfileView.pickerView.delegate = self
        myPageProfileView.pickerView.dataSource = self
    }
    
    func getDailyData() {
        FirestoreService().getDailyData { result in
            self.dailyData = result
            self.downloadImage()
            self.getProfileData()
            self.myPagePostView.dailyCollectionView.reloadData()
        }
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
        }
    }
    
    func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(myPageProfileView)
        view.addSubview(myPagePostView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myPageProfileView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        myPagePostView.snp.makeConstraints {
            $0.top.equalTo(myPageProfileView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(65 + 16)
        }
    }
    
    private func setProfile() {
        myPageProfileView.userNameLabel.text = "이름"
        myPageProfileView.petAgeLabel.text = "나이"
        myPageProfileView.petGenderLabel.text = "성별"
        myPageProfileView.petBreedLabel.text = "종류"
    }
    
    private func setActions() {
        myPageProfileView.editProfileButton.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
    }
    
    func setProfileImage() {
        if let url = profileData?.imageURL {
            if let url = URL(string: url) {
                myPageProfileView.profileImage.load(url: url)
            }
        }
    }
    
    func downloadImage() {
        self.dailyData?.forEach { daily in
            FirebaseStorageManager.downloadImage(urlString: daily.video ?? "") { image in
            }
        }
    }

    func setSegmentedControl() {
        myPagePostView.postSegmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        print("@@@@ mymy \(myPagePostView.postSegmentControl.selectedSegmentIndex)")
        didChangeValue(segment: myPagePostView.postSegmentControl)
    }
    
    func setCollectionView() {
        myPagePostView.dailyCollectionView.delegate = self
        myPagePostView.dailyCollectionView.dataSource = self
        myPagePostView.infoCollectionView.delegate = self
        myPagePostView.infoCollectionView.dataSource = self
    }
    
    @objc func tappedEditButton() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        myPagePostView.shouldHideFirstView = segment.selectedSegmentIndex != 0
        if segment.selectedSegmentIndex == 0 {
            myPagePostView.dailyCollectionView.collectionViewLayout.invalidateLayout()
        } else {
            myPagePostView.infoCollectionView.collectionViewLayout.invalidateLayout()
        }
     }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myPagePostView.dailyCollectionView {
            return dailyDummy.count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if myPagePostView.postSegmentControl.selectedSegmentIndex != 1 {
            let cell = myPagePostView.dailyCollectionView.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.identifier, for: indexPath) as! MyPageCollectionViewCell
            cell.collectionViewImage.image = dailyDummy[indexPath.row]
            return cell
        } else {
            let cell = myPagePostView.infoCollectionView.dequeueReusableCell(withReuseIdentifier: ShareInfoViewCell.identifier, for: indexPath) as! ShareInfoViewCell
            cell.configure(title: "제목", description: "내용", writer: "작성자", tag: "애완동물 & 자유로운", image: UIImage(named: "sample1"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if myPagePostView.postSegmentControl.selectedSegmentIndex != 1  {
            print("@@@@ 데일리")
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = (collectionViewWidth - 5) / 3
            let cellHeight = cellWidth
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            print("@@@@ 인포")
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = collectionViewWidth - 10
            let cellHeight: CGFloat = 100
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}

extension MyPageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return profileList.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return profileList[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            myPageProfileView.profileTextField.text = profileList[row]
        }
}

extension MyPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
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
