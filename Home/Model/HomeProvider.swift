//
//  API.swift
//  Home
//
//  Created by 김민령 on 2023/02/10.
//

import Foundation
import Common
import Moya

enum HomeProvider {
    case mainInfo
}

extension HomeProvider : TargetType {
    var baseURL: URL {
        return URL(string: "\(API.baseURL):\(API.port.development)")!
    }

    var path: String {
        switch self {
        case .mainInfo:
            return "/api/test/main/info"
        }
    }

    var method: Moya.Method {
        switch self {
        case .mainInfo:
            return .get
        }
    }

    var task: Moya.Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return API.header
    }


}
