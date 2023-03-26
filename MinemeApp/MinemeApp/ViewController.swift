//
//  ViewController.swift
//  MinemeApp
//
//  Created by 김민령 on 2022/11/05.
//

import UIKit
import Home
import Story
import Setting
import Onboarding
import Login
import RxSwift
import Common

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}

class ViewController: UITabBarController {
    
    private let onboardingManager = OnboardingManager()

    override func viewDidLoad() {
        print("rootViewController viewDidLoad")
        
        super.viewDidLoad()
        
        let HomeTab = UINavigationController(rootViewController: HomeViewController())
        let StoryTab = UINavigationController(rootViewController: StoryHomeViewController())
        let SettingTab = UINavigationController(rootViewController: SettingViewController())
        
        HomeTab.setNavigationBarHidden(true, animated: false)
        StoryTab.setNavigationBarHidden(true, animated: false)
        SettingTab.setNavigationBarHidden(true, animated: false)
        
        HomeTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "default-home"), selectedImage: UIImage(named: "selected-home"))
        StoryTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "default-story"), selectedImage: UIImage(named: "selected-story"))
        SettingTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "default-setting"), selectedImage: UIImage(named: "selected-setting"))
        
        //필요한 탭 위와 같은 방식으로 추가하기
        self.viewControllers = [HomeTab, StoryTab, SettingTab]
        initAttribute()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("rootViewController viewDidAppear")
        
        if let startView = startView() {
            startView.modalPresentationStyle = .fullScreen
            present(startView, animated: true)
        }

    }
    
    func startView() -> UIViewController? {
        switch UserdefaultManager.startMode {
        case .onboarding:
            return OnboardingViewController()
        case .oauth:
            return LoginViewController()
        case .enterCode:
            return InviteViewController()
        case .waitingConnection:
            return InviteViewController()
        case .main:
            return nil
        }
    }
    
    func initAttribute(){
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        
        // MARK - tabBar shadow attribute
        tabBar.layer.shadowColor = UIColor.black.cgColor //modify
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowRadius = 4
    }
}
