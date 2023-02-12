//
//  CommonAPIResponder.swift
//  Common
//
//  Created by 김민령 on 2023/01/18.
//

import Foundation
import Moya

public struct APIResponder<CommonDataDTO: Decodable> {
    
    public init(){}
    
    public static func parseResponse(_ result: Result<Response, MoyaError>) -> Result<Any?, Error> {
        
        switch result {
        case .success(let response):
            do {
                
                let commonResponse = try JSONDecoder().decode(ResponseDTO<CommonDataDTO>.self, from: response.data)
                if let error = commonResponse.error {
                    return .failure(error)
                }
                return .success(commonResponse.data)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
        
    }
}
