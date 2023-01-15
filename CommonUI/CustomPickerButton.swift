//
//  CustomPickerButton.swift
//  CommonUI
//
//  Created by 김민령 on 2022/12/21.
//

import UIKit
import SnapKit

class CustomPickerButton: UIButton {

    private var uiView = UIView()
    private var label = UITextField()
    private var btn = UIImageView()
    
    init(placeholder: String, width: CGFloat){
        super.init(frame: .zero)
        initAttribute()
        label.text = placeholder
        initAutolayout(width: width)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        
        uiView = {
            let uiView = UIView()
            uiView.layer.borderWidth = 1
            uiView.layer.cornerRadius = 10
            uiView.layer.borderColor = UIColor.lightGray.cgColor

            return uiView
        }()
        
        label = {
            let label = UITextField()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .lightGray
        
            return label
        }()
        
        btn.image = UIImage(named: "btn-bottom")
        btn.sizeToFit()
        
    }
    
    func initAutolayout(width: CGFloat){
        
        [uiView, label, btn ].forEach {
            self.addSubview($0)
        }
        self.bringSubviewToFront(label)
        
        
        uiView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(50)
        }
        
        label.snp.makeConstraints {
            $0.left.equalTo(uiView).offset(34)
            $0.centerY.equalToSuperview()
        }
        
        btn.snp.makeConstraints {
            $0.right.equalTo(uiView).offset(-11)
            $0.centerY.equalToSuperview()
        }

        
    }
    
//    func setPicker(data: [String]){
//        self.data = data
//    }

}
