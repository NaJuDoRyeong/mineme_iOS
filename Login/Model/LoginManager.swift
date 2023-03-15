//
//  LoginManager.swift
//  Login
//
//  Created by 김민령 on 2023/03/16.
//

import Foundation
import Common

class LoginManager {
    
    @UserDefault(key: "jwt", value: nil)
    static var jwt : String?
    
    @UserDefault(key: "code", value: nil)
    static var code : String?
    
}
