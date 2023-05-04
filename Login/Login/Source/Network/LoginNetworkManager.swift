
import Foundation
import Common
import RxSwift

class LoginNetworkManager : BaseNetworkManager<LoginProvider> {
    
    func login(_ type: LoginProvider) -> Single<Result<SuccessDTO<LoginDTO>,Error>> {
        return request(type)
    }
    
    func enterInfo(_ userInfo: PreUserInfo) -> Single<Result<SuccessDTO<Bool?>, Error>> {
        return request(.enterInfo(preUserInfo: userInfo))
    }
}
