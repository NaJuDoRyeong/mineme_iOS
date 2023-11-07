import Foundation
import Moya
import RxSwift

public struct NetworkManager<Target: TargetType, DTO: Decodable> {
    
    let provider = MoyaProvider<Target>()
    
    public init() {}
    
    public func request(_ type : Target) -> Single<Result<DTO?, Error>> {

        return provider.rx.request(type)
            .map(ResponseDTO<DTO>.self)
            .map{
                if $0.success {
                    return .success($0.data)
                }
                else {
                    return .failure($0.error!)
                }
            }

    }
}

open class BaseNetworkManager<Target : TargetType>{
    let provider = MoyaProvider<Target>()
    
    public init() {}
    
    public func request<DTO: Decodable>(_ type: Target) -> Single<Result<SuccessDTO<DTO>, Error>> {
        return provider.rx.request(type)
            .map {
                let response = try $0.map(ResponseDTO<DTO>.self)
                if response.success {
                    return .success(SuccessDTO(code: $0.statusCode, data: response.data))
                }
                else{
                    return .failure(response.error!)
                }
            }
    }
    
    public func request(_ type: Target) -> Single<Response> {
        return provider.rx.request(type)
    }
}

