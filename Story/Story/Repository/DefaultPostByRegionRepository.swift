

import Foundation
import RxSwift

class DefaultPostByRegionRepository : PostByRegionRepository {
    let networkManager : StoryNetworkManager
    
    init(_ networkManager : StoryNetworkManager){
        self.networkManager = networkManager
    }
    
    func fetchPost() -> Observable<[PostByRegion]> {
        return networkManager.fetchPostByRegion()
            .asObservable()
            .map { result in
                switch result {
                case .success(let data):
                    guard let dto = data.data else{
                        return []
                    }
                    return dto.stories
                case .failure:
                    return []
                }
            }
    }
    
}
