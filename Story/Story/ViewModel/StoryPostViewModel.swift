//
//  StoryPostViewMode.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import Foundation
import RxSwift
import Common
import RxCocoa

class StoryPostViewModel {
    
    enum ViewType {
        case enterInfo
        case writeContent
    }
    
    let defaultContents = "무슨 이야기를 남기고 싶나요?"
    
    var viewType : ViewType
    
    var date = BehaviorRelay(value: "")
    var location = PublishSubject<String>()
    var contents : String?
    var images : [Data]?
    
    var isPosting = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    init(viewType: ViewType){
        print("StoryPostViewModel init")
        self.viewType = viewType
    }
    
    func posting() {
//        postingContents()
        postingPhotos()
    }
    
    func postingContents(){
//        guard let text = text else { return }
//        if text.isEmpty || text == defaultContents {
//            return
//        }
        let networkManager = NetworkManager<StoryProvider, String>()
        let date = date.value.replacingOccurrences(of: " ", with: "-")
        let dateFormat = CommonDateFormatter().StringToDate(date, format: "yyyy-M-dd")
        let stringFormat = CommonDateFormatter().DateToString(dateFormat!, format: "yyyy-MM-dd")
        let post = PostDTO(date: stringFormat, title: "a", content: contents!)
        print(post)
        
        networkManager.request(.postContents(postModel: post))
            .subscribe(onSuccess: { [weak self] result in
                switch result {
                case .success(_):
                    print("success")
                    self?.isPosting.onNext(true)
                case .failure(_):
                    print("failure")
                }
            }).disposed(by: disposeBag)
    }
    
    func postingPhotos(){
        let networkManager = NetworkManager<StoryProvider, ImagesDTO>()
        
        print("images size : \(images)")
        networkManager.request(.postPhotos(photos: images!))
            .subscribe { event in
                switch event {
                case .success(_):
                    print("success image upload")
                case .failure(let error):
                    print("failure image upload")
                    print(error.localizedDescription)
                }
            }.disposed(by: disposeBag)
        
    }
    
    
    deinit{
        print("StoryPostViewModel deinit")
    }
    
}
