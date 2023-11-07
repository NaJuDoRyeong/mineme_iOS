
import Foundation
import RxSwift

protocol PostRepository {
    func fetchPost() -> Observable<[PostPreview]>
}
