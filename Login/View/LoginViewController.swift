//
//  OauthLoginViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import SnapKit

public class LoginViewController: UIViewController {
    
    let logo = UIImageView()
    let kakaoButton = KakaoLoginButton()
    let appleButton = AppleLoginButton()

    public override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutolayout()
        test()
    }
    
    func initAttribute(){
        self.view.backgroundColor = .white
        logo.image = UIImage(named: "icon-app-name")
    }
    
    func initAutolayout(){
        [logo, kakaoButton, appleButton].forEach {
            self.view.addSubview($0)
        }
        
        logo.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(54)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
    }
    
}

extension LoginViewController {
    
    func test(){
        kakaoButton.addTarget(self, action: #selector(nextProcess), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(nextProcess), for: .touchUpInside)
    }
    
    @objc func nextProcess(){
        let presenter = LoginInformationViewController()
        presenter.modalPresentationStyle = .fullScreen
        
        present(presenter, animated: true)
    }
}
