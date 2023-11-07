

import Foundation
import RxSwift

class DummyPostByCalendarRepository : PostByCalendarRepository {
    
    func fetchPost(year: Int, month: Int) -> Observable<PostByCalendar> {

        var postPreview = [PostPreview]()
        for _ in 0..<5{
            let random = Int.random(in: 1..<20)
            let temp = PostPreview(date: "\(year)-\(month)-\(random)", thumbnail: "https://picsum.photos/500/500", postID: random)
            postPreview.append(temp)
        }
        
        return Observable.create{ observar in
            observar.onNext(PostByCalendar(year: "\(year)", month: "\(month)", posts: postPreview))
            observar.onCompleted()
            
            return Disposables.create()
        }
    }
    
}
