//
//  InfoTableViewCell.swift
//  Petmily
//
//  Created by t2023-m0061 on 2023/08/16.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    var info: Info?
    
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var userTimeLabel: UILabel!
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    func setInfo(_ _info: Info) {
        info = _info
        
        guard let info = info else {
            return
        }
        
        tagLabel.text = info.tag
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        userTimeLabel.text = "\(info.userName) · \(DateFormatter.formatInfoDate(date: info.time))"
        
        if let image = info.images.first {
            imageLabel.image = image
        } else {
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

extension DateFormatter {
    static func formatInfoDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}



