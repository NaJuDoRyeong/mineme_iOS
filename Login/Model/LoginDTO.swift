//
//  LoginDTO.swift
//  Login
//
//  Created by 김민령 on 2023/03/10.
//

import Foundation

struct LoginDTO : Decodable {
    let jwt : String
    let code : String
}
