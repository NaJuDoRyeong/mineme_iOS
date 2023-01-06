//
//  TestUIViewController.swift
//  MinemeApp
//
//  Created by 김민령 on 2022/12/21.
//

import UIKit
import CommonUI
import SnapKit

class TestUIViewController: UIViewController {
    
    private let customPicker = CustomDatePicker(title: "생년월일")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
    }
    
    func initAttribute(){
        
    }
    
    func initAutolayout(){
        [customPicker].forEach {
            self.view.addSubview($0)
        }
        
        customPicker.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
