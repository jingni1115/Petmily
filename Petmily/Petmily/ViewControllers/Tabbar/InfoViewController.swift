//
//  InfoViewController.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoViewController: BaseViewController {
    private let infoView = InfoView()
    private let viewModel = InfoViewModel()
    
    override func loadView() {
        super.loadView()
        
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

private extension InfoViewController {
    func setLayout() {
        view.addSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure() {
        infoView.collectionView.delegate = self
        infoView.collectionView.dataSource = self
    }
}

extension InfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShareInfoViewCell.identifier,
            for: indexPath) as? ShareInfoViewCell else { return UICollectionViewCell() }
        cell.configure(
            title: "제목",
            description: "내용",
            writer: "작성자",
            tag: "애완동물 & 자유로운",
            image: UIImage(named: "sample1"))
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.identifier,
                    for: indexPath) as? SectionHeaderView else { return SectionHeaderView() }
                let title = viewModel.getSectionTitle(section: indexPath.section)
                headerView.configure(title: title, buttonOn: true)
                return headerView
            }
            return UICollectionReusableView()
    }
}

extension InfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("======> indexPath: \(indexPath)")
    }
}
