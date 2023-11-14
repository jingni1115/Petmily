//
//  InfoView.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoView: UIView {
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .init())
        view.register(PopularContentCell.self,
                      forCellWithReuseIdentifier: PopularContentCell.identifier)
        view.register(ShareInfoViewCell.self,
                      forCellWithReuseIdentifier: ShareInfoViewCell.identifier)
        view.register(SectionHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: SectionHeaderView.identifier)
        view.setCollectionViewLayout(collectionViewLayout(), animated: true)
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
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

private extension InfoView {
    func setLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(AppConstraint.headerViewHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNum, env  in
            switch sectionNum {
            case 0:
                return self.popularSection()
            case 1:
                return self.infoSection()
            default:
                return self.infoSection()
            }
        }
    }
}

private extension InfoView {
    func popularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .estimated(146))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 16, bottom: 50, trailing: 16)
        section.interGroupSpacing = 16
        
        let sectionHeader = headerSection()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func infoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(152))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 10, trailing: 16)
        section.interGroupSpacing = 16
        
        let sectionHeader = headerSection()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func headerSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return sectionHeader
    }
}
