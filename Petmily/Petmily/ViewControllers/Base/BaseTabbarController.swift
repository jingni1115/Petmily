//
//  BaseTabbarController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit

class BaseTabbarController: UITabBarController {
    enum TabBarMenu: Int {
        case Daily = 0 // 데일리
        case Info // 정보공유
        case Add // 추가
        case Adopt // 펫스티벌
        case MyPage // 마이페이지
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabControllers()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /**
     @brief TabBarController의 item 이미지 및 컬러 설정
     */
    func setTabControllers() {
        let dailyVC = DailyViewController(nibName: "DailyViewController", bundle: nil)
        let infoVC = InfoViewController(nibName: "InfoViewController", bundle: nil)
        let addVC = AddViewController(nibName: "AddViewController", bundle: nil)
        let adoptVC = AdoptViewController(nibName: "AdoptViewController", bundle: nil)
        let mypageVC = MyPageViewController(nibName: "MyPageViewController", bundle: nil)
        
        // init tabbar controller
        let controllers = [dailyVC, infoVC, addVC, adoptVC, mypageVC]
        self.viewControllers = controllers
        
        self.tabBar.borderWidth = 1
        self.tabBar.borderColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        // 데일리
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![0].image = UIImage(named: "icNaviHome")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![0].selectedImage = UIImage(named: "icNaviHomeOn")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![0].title = "데일리"
        
        // 정보공유
        self.tabBar.items![1].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![1].image = UIImage(named: "icNaviCafe")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![1].selectedImage = UIImage(named: "icNaviCafeOn")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![1].title = "정보공유" // Cafééé
        
        // 추가
        self.tabBar.items![2].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![2].image = UIImage(named: "icNaviConnect")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![2].selectedImage = UIImage(named: "icNaviConnectOn")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![2].title = "Add"
        
        // 펫스티벌
        self.tabBar.items![3].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![3].image = UIImage(named: "icNaviConnect")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![3].selectedImage = UIImage(named: "icNaviConnectOn")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![3].title = "펫스티벌"
        
        // 마이페이지
        self.tabBar.items![4].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![4].image = UIImage(named: "icNaviOther")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![4].selectedImage = UIImage(named: "icNaviOtherOn")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![4].title = "마이페이지"
        
        // iOS13이상에서 탭바의 타이틀 컬러가 적용안되는 이슈 해결 modify by subway 20191024
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()

            appearance.backgroundColor = .white
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .white

            appearance.stackedLayoutAppearance.normal.iconColor = .black
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
//              NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!
            ]

            appearance.stackedLayoutAppearance.selected.iconColor = .blue
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.231372549, green: 0.3568627451, blue: 0.8509803922, alpha: 1),
//              NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!
            ]

            self.tabBar.standardAppearance = appearance

        } else {
            // init tabbar item textColor
            UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
                NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!,
            ], for: .normal)
                 
            UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.231372549, green: 0.3568627451, blue: 0.8509803922, alpha: 1),
                NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!,
            ], for: .selected)
        }
    }
    
    /**
     @brief TabBarController에서 입력받은 index로 이동
     
     @param TabBarController에서 이동하고자 하는 index
     */
    func moveToTabBarIndex(index: TabBarMenu) {
        AppDelegate.applicationDelegate().tabBarController!.selectedIndex = index.rawValue
    }
    
    /**
     @brief TabBarController에 현재 선택되어진 index를 리턴
     */
    func selectedTabBarIndex() -> TabBarMenu {
        return TabBarMenu(rawValue: AppDelegate.applicationDelegate().tabBarController!.selectedIndex) ?? TabBarMenu.Daily
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

extension BaseTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            // do your stuff
        }
        print("tabBarIndex : \(tabBarIndex)")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let currentIndex = tabBarController.selectedIndex
        print("currentIndex : \(currentIndex)")
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }

        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
