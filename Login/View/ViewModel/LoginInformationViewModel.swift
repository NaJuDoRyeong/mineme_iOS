//
//  LoginInformationViewModel.swift
//  Login
//
//  Created by 김민령 on 2023/04/03.
//

import Foundation
import Common
import RxSwift
import RxCocoa

class LoginInformationViewModel {
    
    let disposeBag = DisposeBag()
    var startMode = BehaviorRelay(value: UserdefaultManager.startMode)
    
    func setUserInfo(name: String?, birthday: String?){
        guard let name = name, let birthday = birthday?.replacingOccurrences(of: " ", with: "-") else {
            return
        }
    
        let networkManager = NetworkManager<LoginProvider, String>()
        let userInfo = PreUserInfo(nickname: name, birthday: birthday)
        print(userInfo)
        networkManager.request(.enterInfo(preUserInfo: userInfo))
            .subscribe { [weak self] result in
                switch result{
                case .success(_):
                    print("success")
                    self?.startMode.accept(.enterCode)
                case .failure(_):
                    print("fail")
                }
            }.disposed(by: disposeBag)
    }
    
}
