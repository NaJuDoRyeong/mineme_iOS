//
//  StoryDatePicker.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import UIKit

class DateLabel: UIButton {
    
    var label = UILabel()
    private let selectBtn = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        label.text = dateFormatter(Date())
//        label.frame.origin = CGPoint(x: 0, y: 0)
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.textColor = .black
        
        selectBtn.image = UIImage(named: "icon-drop-down")
        
        self.label.isUserInteractionEnabled = false
        
    }
    
    func initAutolayout(){
        [label, selectBtn].forEach {
            self.addSubview($0)
        }
        
        selectBtn.snp.makeConstraints {
            $0.left.equalTo(label.snp.right)
            $0.top.equalTo(label)
            $0.bottom.equalTo(label)
            $0.right.equalToSuperview()
        }

    }
    
    //TODO: common으로 옮기기
    func dateFormatter(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd"
        let current_date_string = formatter.string(from: date)
        return current_date_string
    }
    
    func changeDate(_ date : Date){
        self.label.text = dateFormatter(date)
        self.label.sizeToFit()
    }

}
