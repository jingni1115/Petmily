//
//  ReplyViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/20.
//

import UIKit

class ReplyViewController: BaseViewController {
    
    @IBOutlet weak var tvMain: UITableView!
    @IBOutlet weak var tfReply: UITextField!
    @IBOutlet weak var csrConfirmBottomMargin: NSLayoutConstraint!
    
    var replyData: [DailyModel]?
    var requestReplyData: [String: String]?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ReplyTableViewCell", bundle: nil)
        tvMain.register(nib, forCellReuseIdentifier: "ReplyTableViewCell")
        self.tvMain.delegate = self
        self.tvMain.dataSource = self
        tfReply.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(_keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        getDailyData()
    }
    
    func getDailyData() {
        // 데이터 읽어오기 사용 예시
        FirestoreService().getDailyData() { result in
            CommonUtil.print(output: "Result of Daily : \(result)")
            self.replyData = result
            self.tvMain.reloadData()
        }
    }
    
    func requestAddReply() {
        FirestoreService().addDailyReply(reply: requestReplyData ?? [:]) { resutlt in
            self.getDailyData()
        }

    }
    
    /** @brief textField enter Event, next */
    @objc func _keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            var inset:UIEdgeInsets = self.tvMain.contentInset
            inset.bottom = keyboardHeight - Common.kBottomHeight
            tvMain.contentInset = inset
            self.csrConfirmBottomMargin.constant = inset.bottom
        }
    }
    /** @brief textField enter Event, close */
    @objc func _keyboardWillHide(_ notification: Notification) {
        tvMain.contentInset = .zero
        csrConfirmBottomMargin.constant = 0
    }
    
    @IBAction func addReplyButtonTouched(_ sender: Any) {
        requestReplyData = replyData?[index].reply
        requestReplyData?.updateValue(tfReply.text ?? "", forKey: DataManager.sharedInstance.userInfo?.name ?? "")
        requestAddReply()
    }
}

extension ReplyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replyData?[index].reply.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyTableViewCell", for: indexPath) as! ReplyTableViewCell
        var name: [String] = []
        var reply: [String] = []
        for (key,value) in replyData?[index].reply ?? [:] {
            name.append(key)
            reply.append(value)
        }
        cell.lblName.text = name[indexPath.row]
        cell.lblReply.text = reply[indexPath.row]
        
        return cell
    }
    
    
}

extension ReplyViewController: UITextFieldDelegate {
    
}
