
import Foundation
import RxSwift

class DummyPostByRegionRepository: PostByRegionRepository {
    let disposeBag = DisposeBag()
    
    func fetchPost() -> Observable<[PostByRegion]> {
        var dummy = [PostByRegion]()
        var postPreview = [PostPreview]()
        for i in 0..<10{
            let temp = PostPreview(date: "2023-06-05", thumbnail: "https://picsum.photos/300/300", postID: i)
            postPreview.append(temp)
        }
        dummy.append(PostByRegion(region: "서울", city: "관악구", posts: postPreview))
        dummy.append(PostByRegion(region: "서울", city: "강남구", posts: postPreview))
        dummy.append(PostByRegion(region: "서울", city: "은평구", posts: postPreview))
        
        return Observable.create{ observar in
            observar.onNext(dummy)
            observar.onCompleted()
            
            return Disposables.create()
        }
    }
}

