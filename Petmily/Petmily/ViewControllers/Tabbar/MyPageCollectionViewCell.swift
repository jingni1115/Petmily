//
//  MyPageCollectionViewCell.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/08/16.
//

import UIKit

class MyPageCollectionViewCell: UICollectionViewCell {
    var collectionViewImage: UIImageView = {
        let Img = UIImageView()
        Img.backgroundColor = .yellow
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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.collectionViewImage.image = UIImage(systemName: "photo")
//    }
    
    func setUpCell() {
        contentView.addSubview(collectionViewImage)
        NSLayoutConstraint.activate([
            collectionViewImage.topAnchor.constraint(equalTo: topAnchor),
            collectionViewImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
