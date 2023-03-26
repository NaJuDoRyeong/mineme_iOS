//
//  NetworkProvider.swift
//  Login
//
//  Created by 김민령 on 2023/03/10.
//

import Foundation
import Common
import Moya

enum LoginProvider {
    case kakao(loginModel : LoginModel)
    case apple(loginModel : LoginModel)
//    case resign
}

extension LoginProvider : CommonTargetType {

    var path: String {
        switch self {
        case .kakao:
            return "/api/v1/auth/kakao"
        case .apple:
            return "/api/v1/auth/apple"
        }
    }

    var method: Moya.Method {
        switch self {
        case .kakao:
            return .post
        case .apple:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .kakao(let loginModel):
            return .requestJSONEncodable(loginModel)
        case .apple(loginModel: let loginModel):
            return .requestJSONEncodable(loginModel)
        }
    }

    var headers: [String : String]? {
        return Authorization
    }
}


