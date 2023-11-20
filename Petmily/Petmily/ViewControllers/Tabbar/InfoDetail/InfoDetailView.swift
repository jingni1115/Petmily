//
//  InfoDetailView.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let infoDetailShareView = InfoDetailShareView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            InfoDetailCommentCell.self,
            forCellWithReuseIdentifier: InfoDetailCommentCell.identifier)
        view.register(
            InfoDetailCommentHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: InfoDetailCommentHeader.identifier)
        view.backgroundColor = .systemBackground
        view.isScrollEnabled = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoDetailView {
    func configure() {
        infoDetailShareView.configure(user: nil, info: nil)
    }
    
    func remakeLayout() {
        collectionView.snp.remakeConstraints {
            $0.top.equalTo(infoDetailShareView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(collectionView.contentSize.height)
        }
    }
}

private extension InfoDetailView {
    func setLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [infoDetailShareView, collectionView].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(AppConstraint.headerViewHeight)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        infoDetailShareView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(infoDetailShareView.snp.height)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(infoDetailShareView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(collectionView.contentSize.height)
        }
    }
}
