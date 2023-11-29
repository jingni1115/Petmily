//
//  InfoContent.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct InfoContent {
    let sectionType: sectionType
    
    enum sectionType: String, CaseIterable {
        case popular
        case share
    }
}
