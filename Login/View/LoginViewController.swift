//
//  OauthLoginViewController.swift
//  Login
//
//  Created by 김민령 on 2023/02/16.
//

import UIKit
import SnapKit
import RxSwift

public class LoginViewController: UIViewController {
    
    let vm = LoginViewModel()
    let disposeBag = DisposeBag()
    
    let logo = UIImageView()
    let kakaoButton = KakaoLoginButton()
    let appleButton = AppleLoginButton()

    public override func viewDidLoad() {
        super.viewDidLoad()
        initAttribute()
        initAutolayout()
        bind()
    }
    
    func bind(){
        vm.status.subscribe(onNext: { [weak self] in
            if $0 == .login {
                self?.nextProcess()
            }
        }).disposed(by: disposeBag)
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
        
        kakaoButton.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
        
    }
    
}

extension LoginViewController {
    
    
    @objc func nextProcess(){
        let presenter = LoginInformationViewController()
        presenter.modalPresentationStyle = .fullScreen
        
        present(presenter, animated: true)
    }
}

@objc
extension LoginViewController {
    func kakaoLogin(){
        vm.kakaoLogin()
    }
    
    func appleLogin(){
        vm.appleLogin()
    }
}
