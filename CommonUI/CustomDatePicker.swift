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
    
    private var years = [String]()
    private var months = [String]()
    private var days = [String]()
    
    private let yearWidth : CGFloat = 126
    private let monthWidth : CGFloat = 103
    private let dayWidth : CGFloat = 103
    
    // 따로 만들어서 common으로 이동하기
    func dateFormatter(_ format : String) -> Int {
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = format
        let string_data = formatter_year.string(from: Date())
        return Int(string_data)!
    }
    
    //TODO: 미완성 !!! year, month에 옵저버 있어야 될듯..
    // 차선책 : 31일까지 두고 선택 했을 때 존재하는 날인지 판별하기
    func finishDay(yy: String, mm: String) -> Int{
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "dd"
        let _ = formatter_year.date(from: yy+mm)
        return 31
    }
    
    func dataSetting(){
        for y in 1990...dateFormatter("yyyy") {
            years.append(String(y))
        }
        for m in 1...12{
            months.append(String(m))
        }
        
        let y = yearPicker.label.text
        let m = monthPicker.label.text
        guard let yy = y, let mm = m else {
            return
        }
        
        let now_date = finishDay(yy: yy, mm: mm)
        
        for d in 1...now_date{
            days.append(String(d))
        }
    }
    
    
    private lazy var yearPicker = CustomPickerButton(placeholder: "YYYY", width: yearWidth, data: years)
    private lazy var monthPicker = CustomPickerButton(placeholder: "MM", width: monthWidth, data: months)
    private lazy var dayPicker = CustomPickerButton(placeholder: "DD", width: dayWidth, data: days)
    
//    private let calendar = Calendar.current
//    private let selectDate = Date()
    
    public init(title: String) {
        super.init(frame: .zero)
        dataSetting()
        initAttribute(title: title)
        initAutolayout()

    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(title: String){
        Titlelabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 17)
            label.text = title
            return label
        }()
    
    }
    
    func initAutolayout(){
        [Titlelabel, yearPicker, monthPicker, dayPicker].forEach {
            self.addSubview($0)
        }
        
        self.addSubview(yearPicker)

        Titlelabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
        }

        yearPicker.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(Titlelabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }

        monthPicker.snp.makeConstraints {
            $0.left.equalTo(yearPicker.snp.right).offset(8)
            $0.top.equalTo(yearPicker)
            $0.bottom.equalToSuperview()
        }

        dayPicker.snp.makeConstraints {
            $0.left.equalTo(monthPicker.snp.right).offset(8)
            $0.top.equalTo(yearPicker)
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }

    }
    
}

