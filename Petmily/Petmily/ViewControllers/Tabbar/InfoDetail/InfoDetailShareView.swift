//
//  InfoDetailShareView.swift
//  Petmily
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class InfoDetailShareView: UIView {
    private lazy var profileView: UIImageView = {
        let imageSize: CGFloat = 50
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.cornerRadius = imageSize / 2
        view.clipsToBounds = true
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(imageSize)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var writerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 4
        
        [titleLabel, writerLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    lazy var moreButon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .right
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        [profileView, labelVStack, moreButon].forEach {
            stack.addArrangedSubview($0)
        }
        labelVStack.snp.makeConstraints {
            $0.leading.equalTo(profileView.snp.trailing).offset(10)
            $0.trailing.equalTo(moreButon.snp.leading).offset(-10)
        }
        return stack
    }()
    
    private lazy var contentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.cornerRadius = 13
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.cornerRadius = 17.5
        textField.borderStyle = .none
        textField.borderColor = .darkGray
        textField.borderWidth = 2
        textField.placeholder = "텍스트 입력"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width:50, height: 0))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .darkGray
        
        button.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return button
    }()
    
    private lazy var emptyView1: UIView = {
        return emptyView
    }()
    
    private lazy var emptyView2: UIView = {
        return emptyView
    }()
    
    private lazy var emptyView3: UIView = {
        return emptyView
    }()
    
    private lazy var emptyView4: UIView = {
        return emptyView
    }()
    
    private lazy var emptyView5: UIView = {
        return emptyView
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        [hStack, emptyView1, contentImageView, emptyView2, contentLabel,
         emptyView3, tagLabel, emptyView4, commentTextField, emptyView5].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
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

extension InfoDetailShareView {
    func configure(user: UserModel?, info: InfoModel?) {
        profileView.image = UIImage(named: "sample1")
        titleLabel.text = "반려견 자랑이에유"
        writerLabel.text = "작성자: 한지욱"
        contentImageView.image = UIImage(named: "sample1")
        contentLabel.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용\n내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용\n내용내용내용내용내용내용내용내용"
        tagLabel.text = "애완동물 종류 & 자유로운 & 강아지"
    }
}

private extension InfoDetailShareView {
    func setLayout() {
        let insetSpacing: CGFloat = 24
        
        [vStack, commentButton].forEach {
            addSubview($0)
        }
        
        vStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(insetSpacing)
        }
        
        emptyView1.snp.makeConstraints {
            $0.height.equalTo(8)
        }
        
        emptyView2.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        emptyView3.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        
        emptyView4.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(26)
        }
        
        emptyView5.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        
        contentImageView.snp.makeConstraints {
            $0.height.equalTo(contentImageView.snp.width)
        }
        
        commentTextField.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        commentButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(commentTextField)
            $0.trailing.equalTo(commentTextField.snp.trailing).inset(17)
        }
    }
    
    var emptyView: UIView {
        return UIView()
    }
}
