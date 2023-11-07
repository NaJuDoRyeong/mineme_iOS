
import Foundation
import RxSwift

class DummyPostingRepository : PostingRepository {
    func posting(_ data: PostingData) -> Observable<Result<Bool, Error>> {
        return Observable.create { observar in
            observar.onNext(.success(true))
            observar.onCompleted()
            return Disposables.create()
        }
    }
    
}
