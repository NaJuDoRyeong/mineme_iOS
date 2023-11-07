
import Foundation
import RxSwift

class DummyPostRepository: PostRepository {
    
    func fetchPost() -> RxSwift.Observable<[PostPreview]> {
        var postPreview = [PostPreview]()
        for i in 0..<10{
            let temp = PostPreview(date: "2023-11-07", thumbnail: "https://picsum.photos/300/300", postID: i)
            postPreview.append(temp)
        }
        
        return Observable.create { observer in
            observer.onNext(postPreview)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

