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
    lazy var myPagePostView = MyPagePostView()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var profileList = ["1번", "2번"]
    var profileData: UserModel?
    var dailyData: [DailyModel]?
    var infoData: [InfoModel]?
    var dailyThumbnail: UIImage?
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "myPageBackground")
        return view
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getDailyData()
        
        setupUI()
        setCollectionView()
        setTableView()
        setSegmentedControl()
        
        myPageProfileView.profileTextField.delegate = self
        myPageProfileView.pickerView.delegate = self
        myPageProfileView.pickerView.dataSource = self
    }
    
    func getDailyData() {
        FirestoreService().getDailyData { result in
            self.dailyData = result?.filter({ filt in
                filt.id == DataManager.sharedInstance.userInfo?.id ?? ""
            })
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
            self.setProfileImage()
//            self.tableView.reloadData()
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
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
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
            print("@@@@@ \(daily)")
            FirebaseStorageManager.downloadImage(urlString: daily.imageURL ?? "") { image in
                print("@@@ \(image)")
            }
        }
    }

    func setSegmentedControl() {
        myPagePostView.postSegmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        myPagePostView.postSegmentControl.selectedSegmentIndex = 0
        didChangeValue(segment: myPagePostView.postSegmentControl)
    }
    
    func setCollectionView() {
        myPagePostView.dailyCollectionView.delegate = self
        myPagePostView.dailyCollectionView.dataSource = self

    }
    
    func setTableView() {
        myPagePostView.infoCollectionView.isHidden = true
    }
    
    @objc func tappedEditButton() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        myPagePostView.shouldHideFirstView = segment.selectedSegmentIndex != 0
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
        let cell = myPagePostView.dailyCollectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCollectionViewCell", for: indexPath) as! MyPageCollectionViewCell
        FirebaseStorageManager.downloadImage(urlString: "gs://petmily-6b63f.appspot.com/DF52E2BD-8489-43F8-824B-C4F4D42B715A1692579160.0970469", completion: { result in
            cell.collectionViewImage.image = result
        })
        return cell
    }
}

extension MyPageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // UIPickerViewDataSource와 UIPickerViewDelegate 메소드
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

// SwiftUI를 활용한 미리보기
struct MyPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        MyPageVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct MyPageVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let MyPageVC = MyPageViewController()
        return UINavigationController(rootViewController: MyPageVC)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    typealias UIViewControllerType = UIViewController
}
