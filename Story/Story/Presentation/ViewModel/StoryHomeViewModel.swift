//
//  StoryHomeViewModel.swift
//  Story
//
//  Created by 김민령 on 2023/03/09.
//

import Foundation
import RxSwift

class StoryHomeViewModel {
    let getPostByRegionUsecase : GetPostByRegionUseCase
    let regions : BehaviorSubject<[String]>
    let posts : BehaviorSubject<[String : [PostPreview]]>
    let disposeBag = DisposeBag()
    
    init(_ getPostByRegionUsecase : GetPostByRegionUseCase = DefaultGetPostByRegionUseCase(DummyPostByRegionRepository())){
        self.getPostByRegionUsecase = getPostByRegionUsecase
        
        regions = BehaviorSubject(value: [])
        posts = BehaviorSubject(value: [:])
        
        getPostByRegionUsecase.regions
            .subscribe(regions)
            .disposed(by: disposeBag)
        
        getPostByRegionUsecase.posts
            .subscribe(posts)
            .disposed(by: disposeBag)
    }
}
