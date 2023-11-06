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
import AuthenticationServices

class LoginViewModel : NSObject {
    
    let loginStatus = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    let networkManager = LoginNetworkManager()
    
    
    func login(_ token: String, _ type: ProviderType, _ name : String, _ code : String? = nil){
        let model = LoginModel(accessToken: token, providerType: type.string, username: name, authorizationCode: code)

        let request : LoginProvider = type == .KAKAO ?
            .kakao(loginModel: model) : .apple(loginModel: model)
        
        networkManager.login(request)
            .subscribe({ [weak self] result in
                switch result {
                case let .success(data):
                    do {
                        let data = try data.get()
                        UserdefaultManager.jwt = data.data?.jwt
                        print("⭐️NEW JWT : \( UserdefaultManager.jwt!)")
                        if data.code == 200 {
                            UserdefaultManager.startMode = .main
                        }
                        else{
                            UserdefaultManager.code = data.data?.code
                            UserdefaultManager.startMode = .initUserInfo
                        }
                        self?.loginStatus.onNext(true)
                    }
                    catch {
                        print("Login Error : \(error.localizedDescription)")
                    }
                case let .failure(error):
                    print("Login Error : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
    }
    
    func logout(_ token: String, _ type: ProviderType, _ name : String, _ code : String? = nil){
        
        let model = LoginModel(accessToken: token, providerType: type.string, username: name, authorizationCode: code)

        let request : LoginProvider = type == .KAKAO ?
            .kakao(loginModel: model) : .apple(loginModel: model)
        networkManager.test(request)
            .subscribe { event in
                switch event {
                case .success(let data):
                    print(data.dat)
                case .failure(_):
                    return
                }
            }
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
                    self?.loginStatus.onNext(false)
                    print("kakaoLogin error : \(error)")
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
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

extension LoginViewModel : ASAuthorizationControllerDelegate {
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                // Apple ID Credential을 사용하여 로그인에 성공한 경우
                
                if let _ = appleIDCredential.email,
                   let _ = appleIDCredential.fullName {
                    print("0️⃣ sign in with Apple : 회원가입")
                    
                    if let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) ,
                       let name = appleIDCredential.fullName?.givenName,
                       let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                    {
                        login(identityToken, .APPLE, name, authorizationCode)
                    }
                    
                } else {
                    print("1️⃣ sign in with Apple : 로그인")
                    if let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) {
                        login(identityToken, .APPLE, "")
                    }
                }
            }

        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // 로그인에 실패한 경우
            // 에러 처리 로직 추가
            loginStatus.onNext(false)
        }
}
