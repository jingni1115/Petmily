//
//  InfoDetailViewController.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailViewController: BaseHeaderViewController {
    private let infoDetailView = InfoDetailView()
    
    override func loadView() {
        super.loadView()
        
        view = infoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeaderView()
        configure()
        setMoreButton()
        infoDetailView.configure()
    }
    
    override func viewDidLayoutSubviews() {
        infoDetailView.remakeLayout()
    }
}

extension InfoDetailViewController {
    func configure() {
        infoDetailView.collectionView.delegate = self
        infoDetailView.collectionView.dataSource = self
    }
}

private extension InfoDetailViewController {
    func setMoreButton() {
        let editImage = UIImage(systemName: "pencil")
        let deleteImage = UIImage(systemName: "trash.fill")
        let moreImage = UIImage(systemName: "ellipsis")
          
        let editAction = UIAction(
            title: "수정",
            image: editImage) { [weak self] _ in
                guard let self else { return }
                self.infoDetailView.infoDetailShareView.moreButon
                    .setImage(editImage, for: .normal)
            }
        
        let deleteAction = UIAction(
            title: "삭제",
            image: deleteImage) { [weak self] _ in
                guard let self else { return }
                self.infoDetailView.infoDetailShareView.moreButon
                    .setImage(deleteImage, for: .normal)
            }
        let cancelAction = UIAction(
            title: "취소",
            attributes: .destructive) { [weak self] _ in
                guard let self else { return }
                infoDetailView.infoDetailShareView.moreButon
                    .setTitle(nil, for: .normal)
                infoDetailView.infoDetailShareView.moreButon
                    .setImage(moreImage, for: .normal)
            }
        
        let moreButton = UIMenu(
            title: "더보기",
            children: [editAction, deleteAction, cancelAction])
        
        infoDetailView.infoDetailShareView.moreButon.menu = moreButton
        infoDetailView.infoDetailShareView.moreButon.showsMenuAsPrimaryAction = true
    }
}

extension InfoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InfoDetailCommentCell.identifier,
                for: indexPath) as? InfoDetailCommentCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: InfoDetailCommentHeader.identifier,
                    for: indexPath) as? InfoDetailCommentHeader else { return UICollectionReusableView() }
                headerView.configure(commentCount: 4)
                return headerView
            }
            return UICollectionReusableView()
        }
}

extension InfoDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: 121)
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: 45)
    }
}

extension InfoDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index: \(indexPath.item)")
    }
}

private extension InfoDetailViewController {
    func setHeaderView() {
        let title = NSMutableAttributedString(
            string: "반려in",
            attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        headerView.titleLabel.attributedText = title
    }
}
