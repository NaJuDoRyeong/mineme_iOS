

import Foundation
import RxSwift

class DefaultPostByCalendarUseCase : GetPostByCalendarUseCase {
    var repository: PostByCalendarRepository
    var posts: BehaviorSubject<[PostPreview]>
    var disposeBag = DisposeBag()
    
    init(_ repository : PostByCalendarRepository = DummyPostByCalendarRepository()){
        self.repository = repository
        posts = BehaviorSubject(value: [])
    }
    
    func fetchPost(year: String, month: String) {
        guard let year = Int(year), let month = Int(month) else {
            assert(false, "\(#function) Int change failure")
            return
        }
        repository.fetchPost(year: year, month: month)
            .map{ $0.posts }
            .subscribe(onNext: posts.onNext)
            .disposed(by: disposeBag)
    }
    
}
