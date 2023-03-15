//
//  NetworkManager.swift
//  Common
//
//  Created by 김민령 on 2023/03/16.
//

import Foundation
import Moya
import RxSwift

public struct NetworkManager<Target: TargetType, DTO: Decodable> {
    
    let provider = MoyaProvider<Target>()
    
    public init() {}
    
    public func request(_ type : Target) -> Single<Result<DTO, Error>> {

        return provider.rx.request(type)
            .map(ResponseDTO<DTO>.self)
            .map{
                if let data = $0.data {
                    return .success(data)
                }
                else {
                    return .failure($0.error!)
                }
            }

    }
}
