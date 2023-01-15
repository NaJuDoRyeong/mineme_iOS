//
//  CalendarModal.swift
//  CommonUI
//
//  Created by 김민령 on 2023/01/15.
//

import UIKit

public class CalendarModal: UIViewController{
    
    private var datePicker = UIDatePicker()
    public var date = Date() {
        willSet(newValue){
            observer(newValue)
        }
    }
    public var observer : (Date) -> Void = { _ in }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        // Do any additional setup after loading the view.
    }
    
    func setting(){
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        self.view.backgroundColor = .white
        
        self.view.addSubview(datePicker)
        self.preferredContentSize = datePicker.frame.size
        
        datePicker.addTarget(self, action: #selector(selectDate(_ :)), for: .valueChanged)
    }
    
    @objc
    func selectDate(_ sender : UIDatePicker){
        date = sender.date
        self.dismiss(animated: true)
    }

}
