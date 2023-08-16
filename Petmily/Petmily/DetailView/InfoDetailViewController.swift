//
//  InfoDetailViewController.swift
//  Petmily
//
//  Created by t2023-m0061 on 2023/08/16.
//

import UIKit

class InfoDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userImageLabel: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var cvInfo: UICollectionView!
    
    var selectedInfo: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        guard let info = selectedInfo else {
            return
        }
        
        // 사용자 정보를 가져와서 사용
        if let user = info.user {
            userImageLabel.image = user.image
            // 사용자 정보 관련 UI 설정
            nameLabel.text = info.userName
            titleLabel.text = info.title
            timeLabel.text = DateFormatter.formatInfoDate(date: info.time)
            contentLabel.text = info.description
            tagLabel.text = info.tag
        }
        
        // 콜렉션 뷰 셀 등록
        cvInfo.register(InfoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "InfoDetailCollectionViewCell")
        
        // 나머지 UI 설정
        cvInfo.isHidden = info.images.isEmpty
        cvInfo.delegate = self
        cvInfo.dataSource = self
        cvInfo.reloadData()
        
        // 데이터 확인용 로그 출력
        print("Selected Info Title: \(info.title)")
        print("Selected Info Time: \(info.time)")
        
        // nil인지 확인
        if userImageLabel.image == nil {
            print("User Image is nil")
        } else {
            print("User Image is not nil")
        }
        
        
        if let firstImage = info.images.first {
            print("Image is not nil")
        } else {
            print("Image is nil")
        }
    }

}

extension InfoDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedInfo?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoDetailCollectionViewCell", for: indexPath) as? InfoDetailCollectionViewCell else {
            return UICollectionViewCell()
        }

        let image = selectedInfo?.images[indexPath.row]
        cell.configure(with: image)

        return cell
    }}
