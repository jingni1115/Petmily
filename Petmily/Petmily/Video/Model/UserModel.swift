//
//  UserModel.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation

struct UserModel: Codable {
    let id: String
    var imageURL: String = ""
    let name: String?
    let animalName: String?
    let gender: String?
    let birth: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case animalName
        case gender
        case birth
        case type
    }
}

struct User: Codable {
    let id: String?
    let nickName: String?
    let image: String?
    let pet: [Pet]?
}
