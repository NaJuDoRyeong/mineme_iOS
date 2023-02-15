//
//  ToastMessage.swift
//  CommonUI
//
//  Created by 김민령 on 2023/02/13.
//

import UIKit
import SnapKit

public class ToastMessage: UIView {
    
    public enum ToastType {
        case common, alert, info
    }
    
    var text = UILabel()
    var icon = UIImageView()
    var type : ToastType
    
    
    public init(type: ToastType){
        self.type = type
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        
        text = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.text = "안녕하세요"
            
            return label
        }()
        
//        switch type {
//        case .common:
//        case .alert:
//        case .info
//        }
    }
    
    func initAutolayout(){
        [text, icon].forEach {
            self.addSubview($0)
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(30)
        }
        
        text.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
    }
    
    public func setText(_ string : String){
        text.text = string
        text.sizeToFit()
    }
    
    public func toast(){
        
        UIView.animate(withDuration: 0.5) {
            print("toast : \(self.text.text!)")
            self.alpha = 0.9
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2) {
                self.alpha = 0
            }
        }

    }
    
}
