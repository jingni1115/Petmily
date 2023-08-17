//
//  InfoDetailViewController.swift
//  Petmily
//
//  Created by t2023-m0061 on 2023/08/16.
//

import UIKit

class InfoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userImageLabel: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var contentImageLabel: UIImageView!
    
    @IBOutlet weak var contentImageHeight: NSLayoutConstraint!
    
    
    var selectedInfo: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        
        // 본문 줄 제한 해제
        contentLabel.numberOfLines = 0
        // 본문 단어 줄 바꿈
        contentLabel.lineBreakMode = .byWordWrapping
        // 스크롤뷰 가능 설정
        scrollView.isScrollEnabled = true
        
        // 내비게이션 바 색깔 변경
        navigationController?.navigationBar.barTintColor = UIColor.white


        
        guard let info = selectedInfo else {
            return
        }
        
        // 사용자 정보를 가져와서 사용
        if let user = info.user {
            if let profileImage = user.image {
                userImageLabel.image = profileImage
            } else {
                userImageLabel.image = UIImage(named: "profile-placeholder")
            }
            // 사용자 정보 관련 UI 설정
            nameLabel.text = info.userName
            titleLabel.text = info.title
            timeLabel.text = DateFormatter.formatInfoDate(date: info.time)
            contentLabel.text = info.description
            tagLabel.text = info.tag
            // 이미지뷰에 이미지 설정 및 히든 처리
            if let firstImage = info.images.first, let actualImage = firstImage {
                contentImageLabel.image = actualImage
                contentImageLabel.isHidden = false
                contentImageHeight.constant = (actualImage.size.height / actualImage.size.width) * contentImageLabel.frame.width
            } else {
                contentImageLabel.isHidden = true
                contentImageHeight.constant = 0
            }
            view.layoutIfNeeded()
        }
    }
}
        
