

import Foundation
import RxSwift

protocol PostingUseCase {
    var repository : PostingRepository { get }
    var isComplete : PublishSubject<Bool> { get }
    func posting(_ data: PostingData)
}
