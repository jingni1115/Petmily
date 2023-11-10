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
    
    override func loadView() {
        super.loadView()
        
        view = infoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

private extension InfoViewController {
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
            withReuseIdentifier: InfoViewCell.identifier,
            for: indexPath) as? InfoViewCell else { return UICollectionViewCell() }
        cell.configure(
            title: "제목",
            description: "내용",
            writer: "작성자",
            tag: "애완동물 & 자유로운",
            image: UIImage(named: "sample1"))
        return cell
    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
}

extension InfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("======> indexPath: \(indexPath)")
    }
}
