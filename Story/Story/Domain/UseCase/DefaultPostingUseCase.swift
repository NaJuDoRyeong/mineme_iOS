

import Foundation
import RxSwift

class DefaultPostingUseCase : PostingUseCase {
    
    var repository: PostingRepository
    var isComplete: PublishSubject<Bool>
    var disposeBag = DisposeBag()
    
    init(_ repository : PostingRepository = DummyPostingRepository()){
        self.repository = repository
        isComplete = PublishSubject<Bool>()
    }
    
    func posting(_ data: PostingData){
        repository.posting(data)
            .subscribe(onNext:{ [weak self] result in
                switch result {
                case .success(_):
                    self?.isComplete.onNext(true)
                case .failure(_):
                    self?.isComplete.onNext(false)
                }
            }).disposed(by: disposeBag)
    }
}
