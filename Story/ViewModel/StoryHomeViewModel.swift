//
//  StoryHomeViewModel.swift
//  Story
//
//  Created by 김민령 on 2023/03/09.
//

import Foundation
import RxSwift

class StoryHomeViewModel {
    
    var contents = [Content]() {
        willSet {
            observable.onNext(contents)
        }
    }
    
    var observable = BehaviorSubject<[Content]>(value: [])
    
    init(){
        setContents()
    }
    
}

//TODO: API 나오면 지울것
extension StoryHomeViewModel {
    func setContents(){
        let dummy = "https://random.imagecdn.app/300/300"
        for i in 0..<10{
            let content = Content(id: i, location: "경상남도 창원시", date: "2023 Mar 9", images: [dummy], text: "~~~")
            contents.append(content)
        }
    }
}
