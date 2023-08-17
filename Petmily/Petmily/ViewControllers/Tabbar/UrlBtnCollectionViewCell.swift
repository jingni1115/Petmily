//
//  UrlBtnCollectionViewCell.swift
//  Petmily
//
//  Created by 허수빈 on 2023/08/16.
//


import UIKit

class UrlBtnCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton! // 버튼 추가

    
    var link: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이미지 뷰의 반지름을 절반으로 설정하여 동그라미 모양으로 만듭니다.
        imageView.layer.cornerRadius = imageView.frame.size.width / 3
        imageView.clipsToBounds = true
        
        linkButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        
        textLabel.font = UIFont.systemFont(ofSize: 14) // 원하는 폰트 크기로 변경
    }
    @objc func openLink() {
            // 버튼을 눌렀을 때 실행될 메서드
            if let urlString = link, let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
