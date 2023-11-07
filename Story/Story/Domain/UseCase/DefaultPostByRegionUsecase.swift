
import Foundation
import RxSwift

class DefaultGetPostUseCase : GetPostUseCase {
    
    let repository: PostRepository
    
    init(_ repository : PostRepository){
        self.repository = repository
    }
    
    func fetchPost() -> Observable<[PostPreview]> {
        return repository.fetchPost()
    }
}
