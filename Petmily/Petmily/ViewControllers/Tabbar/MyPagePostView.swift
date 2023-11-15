//
//  MyPagePostView.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class MyPagePostView: UIView {
    var postView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return view
    }()
    
    var postSegmentControl: UISegmentedControl = {
        var control = UISegmentedControl(items: ["데일리", "정보공유"])
        let font = UIFont.boldSystemFont(ofSize: 20)
        control.setTitleTextAttributes([NSAttributedString.Key.font: font],for: .normal)
        control.selectedSegmentTintColor = .gray
        control.backgroundColor = .white
        control.selectedSegmentIndex = 0
        return control
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.dailyCollectionView.isHidden = shouldHideFirstView
            self.infoCollectionView.isHidden = !self.dailyCollectionView.isHidden
            self.dailyCollectionView.reloadData()
        }
    }
    
    lazy var postStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [dailyCollectionView, infoCollectionView])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var dailyCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        let rowCount: CGFloat = 3
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / rowCount) - 8, height: (UIScreen.main.bounds.width / rowCount) - 4)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        view.showsVerticalScrollIndicator = true
        view.isScrollEnabled = false
        view.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: "MyPageCollectionViewCell")
        return view
    }()
    
    lazy var infoCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.register(ShareInfoViewCell.self, forCellWithReuseIdentifier: ShareInfoViewCell.identifier)
        view.backgroundColor = .purple
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(postView)
        
        postView.addSubview(postSegmentControl)
        postView.addSubview(postStackView)
        
        postView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        postSegmentControl.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(postView)
            $0.height.equalTo(60)
        }
        
        postStackView.snp.makeConstraints{
            $0.top.equalTo(postSegmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalTo(postView)
        }
    }
}