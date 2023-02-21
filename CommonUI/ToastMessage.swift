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
        case success(text: String)
        case info(text: String)
        case error(text: String)
    }
    
    var text = UILabel()
    var icon = UILabel()
    var type : ToastType
    
    
    public init(){
        self.type = .info(text: "")
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //please setting before use
    public func typeSetting(_ type : ToastType){
        self.type = type
        
        switch type {
        case .success(text: let text):
            self.icon.text = "👍"
            self.text.text = text
        case .info(text: let text):
            self.icon.text = "❗️"
            self.text.text = text
        case .error(text: let text):
            self.icon.text = "❌"
            self.text.text = text
        }
        text.sizeToFit()
    }
    
    func initAttribute(){
        
        self.backgroundColor = UIColor(red: 1, green: 0.978, blue: 0.952, alpha: 1)
        self.layer.cornerRadius = 10
        
        text = {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 17)
            
            return label
        }()
        
    }
    
    func initAutolayout(){
        [text, icon].forEach {
            self.addSubview($0)
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(348)
            $0.height.equalTo(80)
        }
        
        icon.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        text.snp.makeConstraints {
            $0.left.equalTo(icon.snp.right).offset(10)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    
    }
    
    public func toast(){
        guard let text = text.text else {
            print("❗️toast: please setting")
            return
        }
        
        UIView.animate(withDuration: 0.5) {
            print("toast : \(text)")
            self.alpha = 0.9
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2) {
                self.alpha = 0
            }
        }

    }
    
}
