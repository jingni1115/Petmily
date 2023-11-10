//
//  TabBarController.swift
//  Petmily
//
//  Created by 김지은 on 2023/11/10.
//

import UIKit
import SnapKit

final class TabBarController: UIViewController {
    
    let dailyVC = DailyViewController(nibName: "DailyViewController", bundle: nil)
    let infoVC = InfoViewController(nibName: "InfoViewController", bundle: nil)
    let locationVC = AdoptViewController(nibName: "AdoptViewController", bundle: nil)
    let mypageVC = MyPageViewController(nibName: "MyPageViewController", bundle: nil)
    private let tabBarView = TabBarView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
        configTabBarBtn()
    }
}

private extension TabBarController {
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(dailyVC.view)
    }
    
    func setLayout() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(65)
        }
    }
    
    @objc func didTappedDaily() {
        view.addSubview(dailyVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.dailyBtn)
    }
    
    @objc func didTappedInfo() {
        view.addSubview(infoVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.infoBtn)
    }
    
    @objc func didTappedLocation() {
        view.addSubview(locationVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.locationBtn)
    }
    
    @objc func didTappedMyPage() {
        view.addSubview(mypageVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.myBtn)
    }
    
    func configTabBarBtn() {
        tabBarView.dailyBtn.addTarget(self, action: #selector(didTappedDaily), for: .touchUpInside)
        tabBarView.infoBtn.addTarget(self, action: #selector(didTappedInfo), for: .touchUpInside)
        tabBarView.locationBtn.addTarget(self, action: #selector(didTappedLocation), for: .touchUpInside)
        tabBarView.myBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    func changeTintColor(buttonType: UIButton) {
        tabBarView.dailyBtn.isSelected = (buttonType == tabBarView.dailyBtn)
        tabBarView.infoBtn.isSelected = (buttonType == tabBarView.infoBtn)
        tabBarView.locationBtn.isSelected = (buttonType == tabBarView.locationBtn)
        tabBarView.myBtn.isSelected = (buttonType == tabBarView.myBtn)
    }
}
