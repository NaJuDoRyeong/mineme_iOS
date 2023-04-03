//
//  StoryPostEnterInfoView.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import UIKit
import Common
import RxSwift
//import RxCocoa

class StoryPostEnterInfoView: UIView {
    
    let datePicker = CustomDatePicker(title: "언제였나요?")
    let locationPicker = CustomLocationPicker()
    
    let storyPostVM : StoryPostViewModel
    var disposeBag = DisposeBag()
    
    init(vm: StoryPostViewModel){
        self.storyPostVM = vm
        super.init(frame: .zero)
        backgroundColor = .clear
        initAutolayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        datePicker.observable.subscribe(onNext: { [weak self] _ in
            if let date = self?.datePicker.getDate() {
                self?.storyPostVM.date.accept(date)
            }
            //FIXME: API변경시 수정
            self?.storyPostVM.location.onNext("경상남도 창원에서")
        }).disposed(by: disposeBag)
        
    }
    
    func initAutolayout(){
        [datePicker, locationPicker].forEach {
            self.addSubview($0)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        locationPicker.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(52)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }

}
