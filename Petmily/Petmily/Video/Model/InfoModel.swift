//
//  InfoModel.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation

struct InfoModel: Codable {
    let id: String
    var imageURL: String = ""
    let title: String?
    let content: String?
    let date: String?
    var reply: [String: String]
    var like: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case reply
        case date
    }
}
