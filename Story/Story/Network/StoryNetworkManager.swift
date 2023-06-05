
import Foundation
import RxSwift
import Common

class StoryNetworkManager : BaseNetworkManager<StoryProvider> {
    
    func fetchPostByRegion() -> Single<Result<SuccessDTO<PostByRegionDTO>, Error>>{
        return request(.postByRegion)
    }
}
