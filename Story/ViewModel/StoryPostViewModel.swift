//
//  StoryPostViewMode.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import Foundation
import RxSwift

class StoryPostViewModel {
    
    enum ViewType {
        case enterInfo
        case writeContent
    }
    
    var viewType : ViewType
    
    var date = PublishSubject<String>()
    var location = PublishSubject<String>()
    
    init(viewType: ViewType){
        print("StoryPostViewModel init")
        self.viewType = viewType
    }
    
    deinit{
        print("StoryPostViewModel deinit")
    }
    
}
