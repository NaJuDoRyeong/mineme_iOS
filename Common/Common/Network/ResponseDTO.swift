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

public struct ErrorDTO : Decodable, Error {
    let code : Int
    let message: String
}

public struct SuccessDTO<DTO: Decodable> {
    public let code: Int
    public let data: DTO?
}
