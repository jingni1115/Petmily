//
//  SectionHeaderView.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    func configure(title: String?, buttonOn: Bool = false) {
        sectionTitleLabel.text = title
        if buttonOn {
            editButton.isHidden = false
        } else {
            editButton.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SectionHeaderView {
    func setLayout() {
        [sectionTitleLabel, editButton].forEach {
            addSubview($0)
        }
        
        sectionTitleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
}
