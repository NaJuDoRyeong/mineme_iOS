//
//  HomeViewModel.swift
//  Home
//
//  Created by 김민령 on 2023/02/10.
//

import Foundation
import Common
import RxSwift
//import RxMoya
import Moya

class HomeViewModel {
    
    let provider = MoyaProvider<HomeProvider>()
    var disposeBag = DisposeBag()
    
    var coupleTitle = PublishSubject<String>() //TODO: 이건 없어져야해..
    var myProfile = PublishSubject<Profile>()
    var loverProfile = PublishSubject<Profile>()
    
    func request() {
        
        provider.request(.mainInfo) { [weak self] event in
            let result = APIResponder<MainData>.parseResponse(event)
            switch result {
            case let .success(response):
                guard let response = response as? MainData else { return }
                guard let me = response.couple.me.toDomain() else { return }
                guard let lover = response.couple.mine.toDomain() else { return }

                self?.myProfile.onNext(me)
                self?.loverProfile.onNext(lover)
                self?.coupleTitle.onNext(response.couple.name)

            case let .failure(error):
                print(error)
            }
        }


        // MARK: - RxMoya 모듈 import 안됨
//        provider.rx.request(.mainInfo).subscribe { [weak self] event in
//            let result = APIResponder<MainData>.parseResponse(event)
//            switch result {
//            case let .success(response):
//                guard let response = response as? MainData else { return }
//                guard let me = response.couple.me.toDomain() else { return }
//                guard let lover = response.couple.mine.toDomain() else { return }
//
//                self?.myProfile.onNext(me)
//                self?.loverProfile.onNext(lover)
//
//            case let .failure(error):
//                print(error)
//            }
//        }.disposed(by: disposeBag)
        
    }
    
}
