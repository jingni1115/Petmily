//
//  InfoViewCell.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoViewCell: UICollectionViewCell {
    static let identifier = "InfoViewCell"
    
    private lazy var titleLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 20, weight: .bold)
        return makeLabel(font: font, textColor: .label)
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 18, weight: .medium)
        return makeLabel(font: font, textColor: .label)
    }()
    
    private lazy var contentVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        
        [titleLabel, descriptionLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var writerLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 10, weight: .regular)
        return makeLabel(font: font, textColor: .systemGray)
    }()
    
    private lazy var tagLabel: UILabel = {
        let font: UIFont = .systemFont(ofSize: 10, weight: .bold)
        return makeLabel(font: font, textColor: .white)
    }()
    
    private lazy var tagView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.725, blue: 0.725, alpha: 1)
        view.addSubview(tagLabel)
        
        tagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        return view
    }()
    
    private lazy var infoVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 3
        
        [writerLabel, tagView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 20
        
        [contentVStack, infoVStack].forEach {
            stack.addArrangedSubview($0)
        }
        
        contentVStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
        }
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 13
        view.clipsToBounds = true
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(114)
        }
        return view
    }()
    
    private lazy var contentViewHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 40
        
        [labelVStack, imageView].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoViewCell {
    func configure(title: String, description: String, writer: String, tag: String, image: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        writerLabel.text = writer
        tagLabel.text = tag
        imageView.image = image
    }
}

private extension InfoViewCell {
    func makeLabel(font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = textColor
        label.font = font
        return label
    }
    
    func setLayout() {
        contentView.addSubview(contentViewHStack)
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        
        contentViewHStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        contentVStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
        }
        
        infoVStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
        }
    }
}
