//
//  StoryDatePicker.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import UIKit

class StoryDatePicker: UIButton {
    
    private var label = UILabel()
    private var selectBtn = UIImageView()
    
    override var inputView: UIView? {
        return UIDatePicker()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        label.text = dateFormatter()
//        label.frame.origin = CGPoint(x: 0, y: 0)
        label.sizeToFit()
        label.textColor = .black
    }
    
    func initAutolayout(){
        [label].forEach {
            self.addSubview($0)
        }
    }
    
    //TODO: common으로 옮기기
    func dateFormatter() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd"
        let current_date_string = formatter.string(from: Date())
        return current_date_string
    }

}
