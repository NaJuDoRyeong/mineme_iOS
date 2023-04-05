//
//  TextBox.swift
//  CommonUI
//
//  Created by 김민령 on 2023/01/15.
//

import UIKit

class TextBox: UIView {
    
    private var textField = UITextField()

    init(height: CGFloat){
        super.init(frame: .zero)
        initAttribute(height: height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(height: CGFloat){
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
//        self.clipsToBounds = true
        
        textField = {
            let tf = UITextField()
            tf.font = UIFont.systemFont(ofSize: 14)
            tf.placeholder = "내용을 입력하세요"
            return tf
        }()
    }
    
}
