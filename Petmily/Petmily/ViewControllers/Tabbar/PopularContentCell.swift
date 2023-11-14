//
//  PopularContentCell.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class PopularContentCell: UICollectionViewCell {
    static let identifier = "PopularContentCell"
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        let size: CGFloat = 24
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = size / 2
        view.snp.makeConstraints {
            $0.width.height.equalTo(size)
        }
        return view
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopularContentCell {
    func configure(contentImage: UIImage?, profileImage: UIImage?, tag: String) {
        contentImageView.image = contentImage
        profileImageView.image = profileImage
        tagLabel.text = tag
    }
}

private extension PopularContentCell {
    func setLayout() {
        [contentImageView, profileImageView, tagLabel].forEach {
            contentView.addSubview($0)
        }
        
        contentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.width.equalTo(132)
//            $0.height.equalTo(146)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
