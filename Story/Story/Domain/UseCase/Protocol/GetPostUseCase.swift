

import Foundation
import RxSwift

protocol GetPostUseCase {
    func fetchPost() -> Observable<[PostPreview]>
}
