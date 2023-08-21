//
//  InfoTableViewCell.swift
//  Petmily
//
//  Created by t2023-m0061 on 2023/08/16.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    // Info 데이터 저장을 위한 변수
//    var info: InfoModel?
    
    // 셀 내부 UI 요소 변수
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var userTimeLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBOutlet weak var replyLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    
    // Info 데이터를 설정하여 셀을 업데이트하는 메서드
    func setInfo(info: InfoModel?) {
        guard let info = info else {
            return
        }
        
        // UI 요소들에 정보 데이터 반영
        tagLabel.text = info.hashTag
        titleLabel.text = info.title
        descriptionLabel.text = info.content
        replyLabel.text = String(info.reply.count)
        likeLabel.text = String(info.like)
        userTimeLabel.text = "\(String(describing: info.id)) · \(String(describing: info.date ?? ""))"
        
        
        print("정보 공유 화면 본문 사진 썸네일 :::::::: \(info.imageURL)")
        if info.imageURL != "" {
            FirebaseStorageManager.downloadImage(urlString: info.imageURL ?? "" ) { result in
                self.imageLabel.isHidden = false
                self.imageLabel.image = result
            }
        } else {
            self.imageLabel.isHidden = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

// 날짜 형식을 포맷하는데 사용할 메서드를 DateFormatter 확장으로 정의
extension DateFormatter {
    static func formatInfoDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}



