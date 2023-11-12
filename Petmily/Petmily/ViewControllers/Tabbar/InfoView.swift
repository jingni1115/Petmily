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
        view.register(ShareInfoViewCell.self,
                      forCellWithReuseIdentifier: ShareInfoViewCell.identifier)
        view.register(SectionHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: SectionHeaderView.identifier)
        view.setCollectionViewLayout(collectionViewLayout(), animated: true)
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

private extension InfoView {
    func setLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNum, env  in
            switch sectionNum {
            case 0:
                return self.infoSection()
                
//            case 1:
                
            default:
                return self.infoSection()
            }
        }
    }
}

private extension InfoView {
    func popularSection() {
        
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
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
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
