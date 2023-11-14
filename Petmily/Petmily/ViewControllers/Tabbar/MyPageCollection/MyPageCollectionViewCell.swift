//
//  MyPageCollectionViewCell.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/08/16.
//

import UIKit

import SnapKit

class MyPageCollectionViewCell: UICollectionViewCell {
    var collectionViewImage: UIImageView = {
        let Img = UIImageView()
        Img.backgroundColor = .systemGray3
        Img.translatesAutoresizingMaskIntoConstraints = false
        return Img
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    func setUpCell() {
        contentView.addSubview(collectionViewImage)
        
        collectionViewImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(image: String) {
        if let url = URL(string: image) {
            collectionViewImage.load(url: url)
        }
    }
}
