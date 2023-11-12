//
//  DailyModel.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation
import UIKit

struct DailyModel: Codable {
    let video: String?
    let content: String?
    let reply: [String: String]
    let tag: String?
    let like: [String: String]

    enum CodingKeys: String, CodingKey {
        case video
        case content
        case tag
        case like
        case reply
    }
}
