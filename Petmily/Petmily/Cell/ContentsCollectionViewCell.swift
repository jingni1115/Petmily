//
//  ContentsCollectionViewCell.swift
//  Petmily
//
//  Created by 허수빈 on 2023/08/17.
//

import UIKit

class ContentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var secondLinkBtn: UIButton!
    
    var linkTwo: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이미지 뷰의 반지름을 절반으로 설정하여 동그라미 모양으로 만듭니다.
        secondImage.layer.cornerRadius = secondImage.frame.size.width / 3
        secondImage.clipsToBounds = true

        secondLinkBtn.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        
        secondTextLabel.font = UIFont.systemFont(ofSize: 14) // 원하는 폰트 크기로 변경
        

    }
    @objc func openLink() {
            // 버튼을 눌렀을 때 실행될 메서드
            if let urlString = linkTwo, let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
}
