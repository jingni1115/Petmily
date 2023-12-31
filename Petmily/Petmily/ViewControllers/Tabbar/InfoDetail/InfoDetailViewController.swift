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
    
    @IBOutlet weak var imgHeart: UIImageView!
    
    @IBOutlet weak var lblHeartCount: UILabel!
    
    
    var like: Int = 0
    
    // 이전 화면에서 선택된 정보 데이터
    var selectedInfo: InfoModel?
    var selectedUser : UserModel?
    
    var infoData: [InfoModel]?
    var index = 0
    var requestReplyData: [String: String]?

    
    
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
        
        // 선택된 정보의 사용자 정보가 있을 경우 UI에 반영
        // 사용자 프로필 이미지 설정 또는 기본 이미지 설정
        
        if user.imageURL == "" {
            userImageLabel.image = UIImage(named: "profile-placeholder")
        } else {
            FirebaseStorageManager.downloadImage(urlString: selectedInfo?.imageURL ?? "") { result in
                    self.userImageLabel.image = result
                }
        }

        
        // 사용자 정보 관련 UI 설정
        nameLabel.text = info.id
        titleLabel.text = info.title
        timeLabel.text = info.date
        contentLabel.text = info.content
        tagLabel.text = info.hashTag

        
        
        
        if info.imageURL != "" {
            FirebaseStorageManager.downloadImage(urlString: info.imageURL ?? "", completion: { result in
                self.contentImageLabel.image = result
                self.contentImageLabel.isHidden = false
                self.contentImageHeight.constant = ((result?.size.height ?? 0) / (result?.size.width ?? 0)) * self.contentImageLabel.frame.width
            })
        } else {
            // 첨부된 이미지가 없을 경우 이미지뷰를 숨김 처리하고 높이 조정
            contentImageLabel.isHidden = true
            contentImageHeight.constant = 0
        }
        
        

        
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
    
    @IBAction func heartButtonTouched(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            imgHeart.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            imgHeart.tintColor = UIColor.systemPink
            like += 1
        } else {
            imgHeart.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            imgHeart.tintColor = UIColor.white // 원하는 색상으로 변경 가능
            like -= 1
        }
        // 음수 방지
        if like < 0 {
            like = 0
        }
        requestAddLike()
        lblHeartCount.text = String(like)
    }
    
    
    // 댓글 작성 버튼이 눌렸을 때 호출될 메서드
    func submitReply() {
        if let reply = tfReply.text, !reply.isEmpty {
            
            addInfoReplyData()
            
            // 댓글 작성 후 댓글창 높이 업데이트
            updateReplyTableViewHeight()
            tfReply.text = "" // 댓글 작성 후 텍스트 필드 초기화
        }
    }
    
    func requestAddLike() {
        FirestoreService().addInfoLike(title: titleLabel.text ?? "", like: like)
    }
    
    func requestInfoData() {
        FirestoreService().getInfoData() { result in
            CommonUtil.print(output: result)
            if let updatedInfo = result?[self.index] {
                self.selectedInfo?.reply = updatedInfo.reply
                self.tvReply.reloadData()
            }
        }
    }
    
    func addInfoReplyData() {
        let newReply = [DataManager.sharedInstance.userInfo?.name ?? "": tfReply.text ?? ""]
        
        requestReplyData = selectedInfo?.reply ?? [:]
        
        for (key, value) in newReply {
            requestReplyData?[key] = value
        }
        FirestoreService().addInfoReply(title: selectedInfo?.title ?? "", reply: requestReplyData ?? [:]) { result in
            CommonUtil.print(output: result)
            self.requestInfoData()
        }
    }
    
    @IBAction func deleteButtonTouched(_ sender: Any) {
        FirestoreService().deleteInfoDocument()
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

