//
//  ViewController.swift
//  MinemeApp
//
//  Created by 김민령 on 2022/11/05.
//

import UIKit
import Home
import Story

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

    override func viewDidLoad() {
        super.viewDidLoad()
        let HomeTab = UINavigationController(rootViewController: HomeViewController())
        let StoryTab = UINavigationController(rootViewController: StoryHomeViewController())
        
        HomeTab.setNavigationBarHidden(true, animated: false)
        StoryTab.setNavigationBarHidden(true, animated: false)
        
        HomeTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "default-home"), selectedImage: UIImage(named: "selected-home"))
        StoryTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "default-story"), selectedImage: UIImage(named: "selected-story"))
        // 위 같이, 필요한 Tab을 추가해주세요!
        self.viewControllers = [HomeTab, StoryTab]
        initAttribute()
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
