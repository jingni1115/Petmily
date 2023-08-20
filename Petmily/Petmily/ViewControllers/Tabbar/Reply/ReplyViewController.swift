//
//  ReplyViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/20.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var tvMain: UITableView!
    
    var replyData: [DailyModel]?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ReplyTableViewCell", bundle: nil)
        tvMain.register(nib, forCellReuseIdentifier: "ReplyTableViewCell")
        self.tvMain.delegate = self
        self.tvMain.dataSource = self
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
