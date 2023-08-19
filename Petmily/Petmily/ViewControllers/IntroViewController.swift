//
//  IntroViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit

class IntroViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }

    func getUserData() {
        FirestoreService().getUserData { result in
            DataManager.sharedInstance.userInfo = result
            CommonUtil.print(output: result)
            AppDelegate.applicationDelegate().changeInitViewController(type: .Main)
        }
    }
}
