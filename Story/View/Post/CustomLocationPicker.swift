//
//  CustomLocationPicker.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import UIKit
import Common
import RxSwift

class CustomLocationPicker: UIView {
    
    var title = UILabel()
    var cityPicker = CustomPickerButton(placeholder: "위치없음", width: 167)
    var townPicker = CustomPickerButton(placeholder: "", width: 167)
    
    var observable = PublishSubject<Bool>()
    
    init(){
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        title = {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 17)
            label.text = "어디였나요?"
            
            return label
        }()
        
        townPicker.isEnabled = false
    }
    
    func initAutolayout(){
        [title, cityPicker, townPicker].forEach {
            self.addSubview($0)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        cityPicker.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        townPicker.snp.makeConstraints {
            $0.top.equalTo(cityPicker)
            $0.bottom.equalToSuperview()
            $0.left.equalTo(cityPicker.snp.right).offset(14)
            $0.right.equalToSuperview()
        }
    }
}

extension CustomLocationPicker {
    func cityFomatter(){
    }
    
    func townFormatter(){
        
    }
}
