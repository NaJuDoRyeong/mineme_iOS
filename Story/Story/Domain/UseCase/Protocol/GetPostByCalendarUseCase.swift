

import Foundation
import RxSwift

protocol GetPostByCalendarUseCase {
    var repository : PostByCalendarRepository { get }
    var posts : BehaviorSubject<[PostPreview]> { get }
    var disposeBag : DisposeBag { get }
    
    func fetchPost(year: String, month: String)
}
