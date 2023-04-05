//
//  CommonResponseDTO.swift
//  Common
//
//  Created by 김민령 on 2023/01/18.
//

import Foundation

struct ResponseDTO<CommonDataDTO: Decodable> : Decodable {
    var success : Bool
    var data : CommonDataDTO?
    var error : ErrorDTO?
    
}

struct ErrorDTO : Decodable, Error {
    let code : Int
    let message: String
}
