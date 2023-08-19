//
//  DailyModel.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation
import UIKit

struct DailyModel: Codable {
    let id: String
    let imageURL: String?
    let content: String?
    var reply: [String: String]
    let date: String
    var like: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL
        case content
        case date
        case reply
    }
}
