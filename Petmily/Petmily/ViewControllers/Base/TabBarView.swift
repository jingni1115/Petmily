//
//  TabBarView.swift
//  Petmily
//
//  Created by 김지은 on 2023/11/10.
//

import UIKit
import SnapKit

class TabBarView: UIView {
    lazy var dailyBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_daily"), for: .normal)
        button.setImage(UIImage(named: "tab_daily_selected"), for: .selected)
        return button
    }()
    
    lazy var infoBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_info"), for: .normal)
        button.setImage(UIImage(named: "tab_info_selected"), for: .selected)
        return button
    }()
    
    lazy var locationBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_location"), for: .normal)
        button.setImage(UIImage(named: "tab_location_selected"), for: .selected)
        return button
    }()
    
    lazy var myBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tab_my"), for: .normal)
        button.setImage(UIImage(named: "tab_my_selected"), for: .selected)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 (수평, 수직)
        stack.layer.shadowOpacity = 0.1 // 그림자 투명도
        stack.layer.shadowRadius = 10 // 그림자 반경
        
        
        [dailyBtn, infoBtn, locationBtn, myBtn].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
