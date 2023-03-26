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
    
    func login(_ token: String, _ type: ProviderType, _ name : String, _ code : String? = nil){
        let model = LoginModel(accessToken: token, providerType: type.string, username: name, authorizationCode: code)
        
        let networkManager = NetworkManager<LoginProvider, LoginDTO>()
        let request : LoginProvider = type == .KAKAO ?
            .kakao(loginModel: model) : .apple(loginModel: model)
        
        networkManager.request(request)
            .subscribe({ result in
                switch result {
                case let .success(data):
                    do {
                        let loginDTO = try data.get()
                        UserdefaultManager.jwt = loginDTO.jwt
                        UserdefaultManager.code = loginDTO.code
                        print("⭐️NEW JWT : \( UserdefaultManager.jwt!)")
                    }
                    catch {
                        print("Login Error : \(error.localizedDescription)")
                    }
                case let .failure(error):
                    print("Login Error : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
        
        loginStatus.onNext(true)
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
