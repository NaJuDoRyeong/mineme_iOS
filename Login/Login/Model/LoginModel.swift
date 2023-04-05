//
//  LoginModel.swift
//  Login
//
//  Created by 김민령 on 2023/03/10.
//

import Foundation

struct LoginModel : Encodable {
    let accessToken : String
    let providerType : String
    let username : String
    let authorizationCode : String?
}

enum ProviderType {
    case KAKAO
    case APPLE
    
    var string : String {
        switch self {
        case .KAKAO:
            return "KAKAO"
        case .APPLE:
            return "APPLE"
        }
    }
}
