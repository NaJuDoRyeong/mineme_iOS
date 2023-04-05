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

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
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
