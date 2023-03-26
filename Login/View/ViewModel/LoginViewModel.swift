//
//  LoginViewModel.swift
//  Login
//
//  Created by 김민령 on 2023/03/10.
//

import Foundation
import Common
import Moya
import KakaoSDKUser
import RxSwift

class LoginViewModel {
    
    enum LoginStatus {
        case login
        case logout
        case resign
    }
    
    let status = PublishSubject<LoginStatus>()
    let disposeBag = DisposeBag()
    
    func login(_ token: String, _ type: ProviderType, _ name : String, _ code : String? = nil){
        let model = LoginModel(accessToken: token, providerType: type.string, username: name, authorizationCode: code)
        
        let networkManager = NetworkManager<LoginProvider, LoginDTO>()
        
        networkManager.request(.kakao(loginModel: model))
            .subscribe({ result in
                switch result {
                case let .success(data):
                    do {
                        let loginDTO = try data.get()
                        UserdefaultManager.jwt = loginDTO.jwt
                        UserdefaultManager.code = loginDTO.code
                    }
                    catch {
                        print("Login Error : \(error.localizedDescription)")
                    }
                case let .failure(error):
                    print("Login Error : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
            
        status.onNext(.login) //TODO: delete
    }
    
    func logout(){
        
    }
    
    func resign(){
        
    }
}

extension LoginViewModel {
    
    func kakaoLogin(){
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    guard let token = oauthToken?.accessToken else {
                        return
                    }
                    
                    self?.login(token, .KAKAO, "sladuf")
                }
            }
        }
    }
    
    func appleLogin(){
        
    }
}
