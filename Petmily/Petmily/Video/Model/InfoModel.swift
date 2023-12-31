//
//  InfoModel.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation

struct InfoModel: Codable {
    let id: String
    let imageURL: String?
    let title: String?
    let content: String?
    let date: String?
    var hashTag: String?
    var reply: [String: String]
    var like: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case hashTag
        case reply
        case date
        case like
        case imageURL
    }
}
