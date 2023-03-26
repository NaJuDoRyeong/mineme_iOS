//
//  DateSelector.swift
//  CommonUI
//
//  Created by 김민령 on 2022/12/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

open class CustomDatePicker: UIView{
    
    
    // MARK: - deprecated value (refactor and remove)
//    public var allCheck = false
    public var observable = PublishSubject<Bool>()
    
    private var Titlelabel = UILabel()
    
    private let yearWidth : CGFloat = 126
    private let monthWidth : CGFloat = 103
    private let dayWidth : CGFloat = 103
    
    public var allCheck = BehaviorRelay(value: false)
    
    private lazy var yearPicker = CustomPickerButton(placeholder: "YYYY", width: yearWidth)
    private lazy var monthPicker = CustomPickerButton(placeholder: "MM", width: monthWidth)
    private lazy var dayPicker = CustomPickerButton(placeholder: "DD", width: dayWidth)
    
    public init(title: String) {
        super.init(frame: .zero)
        dataSetting()
        initAttribute(title: title)
        initAutolayout()
        bind()

    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var disposeBag = DisposeBag()
    
    func bind(){
        yearPicker.changed.subscribe {
            self.yearCheck($0)
        }.disposed(by: disposeBag)

        monthPicker.changed.subscribe {
            self.monthCheck($0)
        }.disposed(by: disposeBag)
        
        dayPicker.changed.subscribe {
            self.dayCheck($0)
        }.disposed(by: disposeBag)
    }
    
    func initAttribute(title: String){
        Titlelabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 17)
            label.text = title
            return label
        }()
        
        monthPicker.isEnabled = false
        dayPicker.isEnabled = false
    
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

extension CustomDatePicker {
    
    // 따로 만들어서 common으로 이동하기
    func dateFormatter(_ format : String) -> Int {
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = format
        let string_data = formatter_year.string(from: Date())
        return Int(string_data)!
    }
    
    func finishDay(yy: String, mm: String) -> Int{
        let formatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)

        formatter.dateFormat = "yyyy-MM-dd"
        let st = formatter.date(from: "\(yy)-\(mm)-01")!
        let end = calendar.date(byAdding: .month, value: +1, to: st)!
        let result = calendar.dateComponents([.day], from: st, to: end)

        guard let day = result.day else {
            return 0
        }
        return day
    }
    
    func dataSetting(){
        var years = [String]()
        for y in 1970...dateFormatter("yyyy") {
            years.append(String(y))
        }
        yearPicker.setData(data: years.reversed())
        
        var months = [String]()
        for m in 1...12{
            months.append(String(m))
        }
        monthPicker.setData(data: months)
    }
    
    func daySetting(){
        
        let y = yearPicker.getData()
        let m = monthPicker.getData()
        guard let yy = y, let mm = m else {
            dayPicker.setData(data: [])
            return
        }
        
        let now_date = finishDay(yy: yy, mm: mm)
        
        var days = [String]()
        for d in 1...now_date{
            days.append(String(d))
        }
        dayPicker.setData(data: days)
        dayPicker.isEnabled = true
    }
    
    func yearCheck(_ year: String){
        if year != yearPicker.placeholder {
            monthPicker.isEnabled = true
            allCheck.accept(false)
            resetDay()
        }
    }
    func monthCheck(_ month: String){
        if month != monthPicker.placeholder {
            allCheck.accept(false)
            resetDay()
        }
    }
    
    func dayCheck(_ day: String){
        if day != dayPicker.placeholder {
            allCheck.accept(true)
        }
    }
    
    public func getDate() -> String? {
        if let y = yearPicker.getData(), let m = monthPicker.getData(), let d = dayPicker.getData() {
            //FITME: month를 문자열로 수정
            return "\(y) \(m) \(d)"
        }
        return nil
    }
    
    func resetMonth(){
        monthPicker.resetData()
    }
    
    func resetDay(){
        dayPicker.resetData()
        daySetting()
    }
}
