
import Foundation
import RxSwift
import Common

protocol PostingRepository {
    func posting(_ data: PostingData) -> Observable<Result<Bool, Error>>
}
