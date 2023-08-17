//
//  InfoTableViewCell.swift
//  Petmily
//
//  Created by t2023-m0061 on 2023/08/16.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    // Info 데이터 저장을 위한 변수
    var info: Info?
    
    // 셀 내부 UI 요소 변수
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var userTimeLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    // Info 데이터를 설정하여 셀을 업데이트하는 메서드
    func setInfo(_ _info: Info) {
        info = _info
        
        guard let info = info else {
            return
        }
        
        // UI 요소들에 정보 데이터 반영
        tagLabel.text = info.tag
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        userTimeLabel.text = "\(info.userName) · \(DateFormatter.formatInfoDate(date: info.time))"
        
        // 첫 번째 이미지를 셀의 이미지 뷰에 설정
        if let image = info.images?.first {
            imageLabel.image = image
        } else {
            // 이미지가 없을 경우 이미지 뷰를 비움
            imageLabel.image = nil
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



