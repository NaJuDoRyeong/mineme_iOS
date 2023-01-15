//
//  DateSelector.swift
//  CommonUI
//
//  Created by 김민령 on 2022/12/21.
//

import UIKit
import SnapKit

open class CustomDatePicker: UIView{
    
    private var Titlelabel = UILabel()
    
    private var yearPicker = CustomPickerButton(placeholder: "YYYY", width: 126)
    private var monthPicker = CustomPickerButton(placeholder: "MM", width: 103)
    private var dayPicker = CustomPickerButton(placeholder: "DD", width: 103)
    
//    private let calendar = Calendar.current
//    private let selectDate = Date()
    

    
    
    public init(title: String) {
        super.init(frame: .zero)
        initAttribute()
        Titlelabel.text = title
        initAutolayout()

    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        Titlelabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 17)
            
            return label
        }()
    
    }
    
    func initAutolayout(){
        [Titlelabel, yearPicker, monthPicker, dayPicker].forEach {
            self.addSubview($0)
        }
        
        Titlelabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        yearPicker.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(Titlelabel.snp.bottom).offset(4)
        }
        
        monthPicker.snp.makeConstraints {
            $0.left.equalTo(yearPicker.snp.right).offset(8)
            $0.top.equalTo(yearPicker)
        }
        
        dayPicker.snp.makeConstraints {
            $0.left.equalTo(monthPicker.snp.right).offset(8)
            $0.top.equalTo(yearPicker)
        }

    }
    
}

