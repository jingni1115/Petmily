//
//  NSAttributedString+.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

extension NSAttributedString {
    static func makeNavigationTitle(title: String, font: UIFont) -> NSAttributedString {
        let titleFont = font
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: UIColor.label
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        return attributedTitle
    }
}
