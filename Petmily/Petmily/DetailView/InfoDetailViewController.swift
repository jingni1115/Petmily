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
    
    // 이전 화면에서 선택된 정보 데이터
    var selectedInfo: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 뒤로가기 버튼
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // UI 초기 설정 메서드
    func setupUI() {
        // 본문 줄 제한 해제
        contentLabel.numberOfLines = 0
        // 본문 단어 줄 바꿈
        contentLabel.lineBreakMode = .byWordWrapping
        // 스크롤뷰 가능 설정
        scrollView.isScrollEnabled = true
        
        // 내비게이션 바 색깔 변경
        navigationController?.navigationBar.barTintColor = UIColor.white

        // 선택된 정보 (이전 뷰에서 가져온 데이터) 확인
        guard let info = selectedInfo else {
            return
        }
        
        // 선택된 정보의 사용자 정보가 있을 경우 UI에 반영
        if let user = info.user {
            // 사용자 프로필 이미지 설정 또는 기본 이미지 설정
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
            
            // 정보에 첨부된 이미지가 있는 경우 이미지뷰에 이미지 설정 및 크기 조정
            if let firstImage = info.images.first, let actualImage = firstImage {
                contentImageLabel.image = actualImage
                contentImageLabel.isHidden = false
                contentImageHeight.constant = (actualImage.size.height / actualImage.size.width) * contentImageLabel.frame.width
            } else {
                // 첨부된 이미지가 없을 경우 이미지뷰를 숨김 처리하고 높이 조정
                contentImageLabel.isHidden = true
                contentImageHeight.constant = 0
            }
            // UI 업데이트 적용
            view.layoutIfNeeded()
        }
    }
}
        
