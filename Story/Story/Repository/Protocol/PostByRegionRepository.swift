
import Foundation
import RxSwift

protocol PostByRegionRepository {
    func fetchPost() -> Observable<[PostByRegion]>
}
