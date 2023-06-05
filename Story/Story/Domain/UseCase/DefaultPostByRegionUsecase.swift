
import Foundation
import RxSwift

class DefaultGetPostByRegionUseCase : GetPostByRegionUseCase {
    
    let repository: PostByRegionRepository
    let disposeBag = DisposeBag()
    
    var regions: Observable<[String]>
    var posts: Observable<[String : [PostPreview]]>
    
    init(_ repository : PostByRegionRepository){
        self.repository = repository
        
        let getPost = BehaviorSubject<[PostByRegion]>(value: [])
        
        repository.fetchPost()
            .subscribe(onNext: getPost.onNext)
            .disposed(by: disposeBag)
        
        regions = getPost
            .map{ $0.map{ $0.region + $0.city } }
        
        posts = getPost
            .map{ Dictionary(uniqueKeysWithValues: $0.map{ ($0.region + $0.city , $0.posts) })}
        
    }
    
    func fetchPost() {
        repository.fetchPost()
            .subscribe(with: posts)
            .disposed(by: disposeBag)
    }
}
