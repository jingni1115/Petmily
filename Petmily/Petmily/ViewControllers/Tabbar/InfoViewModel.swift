//
//  InfoViewModel.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class InfoViewModel {
    
    func getSectionTitle(section: Int) -> String? {
        switch section {
        case 0: return "🥇지금 인기 있는 콘텐츠"
        case 1: return "정보공유"
        default: return nil
        }
    }
}
