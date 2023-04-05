//
//  SplashViewController.swift
//  MinemeApp
//
//  Created by 김민령 on 2023/03/29.
//

import UIKit
import SnapKit
import Common

class SplashViewController: UIViewController {
    
    private let viewModel = SplashViewModel()
    
    private let appIcon = UIImageView()
    private let appTitle = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initLayout()
    }
    
    func initAttribute(){
        view.backgroundColor = UIColor(named: "butter")
        
        appIcon.image = CommonAssets.appIcon
        appTitle.image = CommonAssets.appTitle
        
        appIcon.sizeToFit()
        appTitle.sizeToFit()
    }
    
    func initLayout(){
        view.addSubview(appIcon)
        view.addSubview(appTitle)
        
        appIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        appTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(appIcon.snp.bottom).offset(13)
        }
    }

}
