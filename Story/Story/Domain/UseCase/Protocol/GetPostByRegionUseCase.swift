

import Foundation
import RxSwift

protocol GetPostByRegionUseCase {
    var repository : PostByRegionRepository { get }
    var regions : Observable<[String]> { get }
    var posts: Observable<[String: [PostPreview]]> { get }
    var disposeBag : DisposeBag { get }
    func fetchPost()
}
