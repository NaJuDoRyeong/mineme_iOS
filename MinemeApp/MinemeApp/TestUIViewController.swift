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
    
    private let customDatePicker = CustomDatePicker(title: "우리가 만난 날")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAutolayout()
    }
    
    func initAttribute(){
        
    }
    
    func initAutolayout(){
        [customDatePicker].forEach {
            self.view.addSubview($0)
        }
        
        customDatePicker.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
