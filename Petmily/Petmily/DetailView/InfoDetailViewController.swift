//
//  InfoDetailViewController.swift
//  Petmily
//
//  Created by t2023-m0061 on 2023/08/16.
//

import UIKit

class InfoDetailViewController: BaseHeaderViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userImageLabel: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var contentImageLabel: UIImageView!
    
    @IBOutlet weak var contentImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tvReply: UITableView!
    
    @IBOutlet weak var tvReplyHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tfReply: UITextField!
    
    // 이전 화면에서 선택된 정보 데이터
    var selectedInfo: InfoModel?
    var selectedUser : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // selectedInfo 데이터 확인
//        if let info = selectedInfo {
//            print("ID: \(info.id)")
//            print("제목: \(info.title)")
//            print("본문: \(info.description)")
//            print("이미지: \(info.images)")
//            print("해시태그: \(info.tag)")
//        } else {
//            print("selectedInfo가 비어있음")
//        }
        setupUI()
        setHeaderTitleName(title: "정보공유")
    }
    
    // 뒤로가기 버튼
    //    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
    //        navigationController?.popViewController(animated: true)
    //    }
    //
    // UI 초기 설정 메서드
    func setupUI() {
        // 본문 줄 제한 해제
        contentLabel.numberOfLines = 0
        // 본문 단어 줄 바꿈
        contentLabel.lineBreakMode = .byWordWrapping
        // 스크롤뷰 가능 설정
        scrollView.isScrollEnabled = true
        
        // 내비게이션 바 색깔 변경
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        // 선택된 정보 (이전 뷰에서 가져온 데이터) 확인
        guard let info = selectedInfo else {
            return
        }
        
        guard let user = selectedUser else {
            return
        }
        
//        // 선택된 정보의 사용자 정보가 있을 경우 UI에 반영
//        // 사용자 프로필 이미지 설정 또는 기본 이미지 설정
//        if let profileImage = user.image {
//            userImageLabel.image = profileImage
//        } else {
//            userImageLabel.image = UIImage(named: "profile-placeholder")
//        }
        
        // 사용자 정보 관련 UI 설정 
        nameLabel.text = user.name
        titleLabel.text = info.title
//        timeLabel.text = DateFormatter.formatInfoDate(date: info.time)
        contentLabel.text = info.content
//        tagLabel.text = info.tag
        
//        // 정보에 첨부된 이미지가 있는 경우 이미지뷰에 이미지 설정 및 크기 조정
//        if let firstImage = info.images?.first, let actualImage = firstImage {
//            contentImageLabel.image = actualImage
//            contentImageLabel.isHidden = false
//            contentImageHeight.constant = (actualImage.size.height / actualImage.size.width) * contentImageLabel.frame.width
//        } else {
//            // 첨부된 이미지가 없을 경우 이미지뷰를 숨김 처리하고 높이 조정
//            contentImageLabel.isHidden = true
//            contentImageHeight.constant = 0
//        }
        
        let nib = UINib(nibName: "ReplyTableViewCell", bundle: nil)
        tvReply.register(nib, forCellReuseIdentifier: "ReplyTableViewCell")
        self.tvReply.delegate = self
        self.tvReply.dataSource = self
        
        tfReply.delegate = self

        
        // UI 업데이트 적용
        view.layoutIfNeeded()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        submitReply()
    }
    
    // 댓글 작성 버튼이 눌렸을 때 호출될 메서드
    func submitReply() {
        if let reply = tfReply.text, !reply.isEmpty {
            // 댓글을 저장하거나 처리하는 코드를 작성
            // selectedInfo?.reply에 추가하거나 데이터베이스에 저장
            // 댓글 작성 후 필요한 업데이트도 수행 가능
            tfReply.text = "" // 댓글 작성 후 텍스트 필드 초기화
            // 댓글 작성 후 댓글창 높이 업데이트
            updateReplyTableViewHeight()
        }
    }
}

extension InfoDetailViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedInfo?.reply.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyTableViewCell", for: indexPath) as! ReplyTableViewCell
        var name: [String] = []
        var reply: [String] = []
        for (key,value) in selectedInfo?.reply ?? [:] {
            name.append(key)
            reply.append(value)
        }
        cell.lblName.text = name[indexPath.row]
        cell.lblReply.text = reply[indexPath.row]
        
        return cell
    }
    
    // 댓글창 높이 업데이트
    func updateReplyTableViewHeight() {
        let numRows = selectedInfo?.reply.count ?? 0
        print("--------------\(numRows)")
        let rowHeight = 68.0
        let newHeight = CGFloat(numRows) * rowHeight
        tvReplyHeight.constant = newHeight
    }
    
    // 뷰가 나타날 때 댓글 테이블 뷰 높이 업데이트
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateReplyTableViewHeight()
    }
    
    // 텍스트 필드의 Return 키를 눌렀을 때 동작 설정
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 닫기
        submitReply() // 댓글 작성 버튼 호출
        return true
    }
}

