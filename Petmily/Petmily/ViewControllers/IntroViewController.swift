//
//  IntroViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit
import Gifu

class IntroViewController: BaseViewController {

    
    @IBOutlet weak var gifImageView: GIFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.animate(withGIFNamed: "launch-screen") {
            print("It's animating!")
        }
        getUserData()
    }

    func getUserData() {
        FirestoreService().getUserData { result in
            DataManager.sharedInstance.userInfo = result
            CommonUtil.print(output: result)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                AppDelegate.applicationDelegate().changeInitViewController(type: .Main)
            }
        }
    }
}
