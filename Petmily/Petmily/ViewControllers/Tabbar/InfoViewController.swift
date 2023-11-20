//
//  InfoViewController.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoViewController: BaseHeaderViewController {
    private let infoView = InfoView()
    private let viewModel = InfoViewModel()
    
    override func loadView() {
        super.loadView()
        
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeaderView()
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
    
    func setHeaderView() {
        let title = NSMutableAttributedString(
            string: "반려in",
            attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        headerView.titleLabel.attributedText = title
        
        backButtonHidden()
        
        headerView.addSubview(infoView.searchButton)
        
        infoView.searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(30)
        }
    }
    
    func configure() {
        infoView.collectionView.delegate = self
        infoView.collectionView.dataSource = self
    }
}

extension InfoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return InfoContent.sectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularContentCell.identifier,
                for: indexPath) as? PopularContentCell else { return UICollectionViewCell() }
            cell.configure(
                contentImage: UIImage(named: "sample2"),
                profileImage: UIImage(named: "image11"),
                tag: "#강아지 #애견샵")
            return cell
            
        case 1:
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
            
        default:
            return UICollectionViewCell()
        }
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
                let section = indexPath.section
                let title = viewModel.getSectionTitle(section: section)
                switch section {
                case 0:
                    headerView.configure(title: title)
                    return headerView
                default:
                    headerView.configure(title: title, buttonOn: true)
                    return headerView
                }
            }
            return UICollectionReusableView()
    }
}

extension InfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infoDetailVC = InfoDetailViewController()
        navigationPushController(viewController: infoDetailVC, animated: true)
    }
}
