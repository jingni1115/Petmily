//
//  InfoDetailCommentCell.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailCommentCell: UICollectionViewCell {
    static let identifier = "InfoDetailCommentCell"
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor(hexString: "FFB9B9")
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.cornerRadius = 2
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        view.snp.makeConstraints {
            $0.height.equalTo(2)
        }
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 11
        
        [stateLabel, titleLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoDetailCommentCell {
    func configure() {
        stateLabel.text = "BEST"
        titleLabel.text = "내 꿈은 스트리머"
        descriptionLabel.text = "내 꿈은 스트리머 입니다."
        dateLabel.text = "6분 전"
    }
}

private extension InfoDetailCommentCell {
    func setLayout() {
        [hStack, descriptionLabel, dateLabel, separateView].forEach {
            contentView.addSubview($0)
        }
        
        stateLabel.snp.makeConstraints {
            $0.width.equalTo(46)
            $0.height.equalTo(16)
        }
        
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(hStack.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(24)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(separateView.snp.top).offset(-5)
            $0.height.equalTo(20)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
        
        separateView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
