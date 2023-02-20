//
//  CommonButton.swift
//  CommonUI
//
//  Created by 김민령 on 2022/12/06.
//

import UIKit
import SnapKit

open class CommonButton: UIButton {
    
    private var text = UILabel()
    
    public init(text: String) {
        super.init(frame: .zero)
        initAttribute(text: text)
        initAutolayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(text: String){
        
        self.backgroundColor = UIColor(named: "butter")
        self.layer.cornerRadius = 24
        self.layer.cornerCurve = .continuous
        
        self.text = {
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 17)
            label.textColor = .black
            
            return label
        }()
    }
    
    func initAutolayout(){
        [text].forEach {
            self.addSubview($0)
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(348)
            $0.height.equalTo(50)
        }
        
        text.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

extension CommonButton {
    
    public func activate(){
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor(named: "butter")
        self.isEnabled = true
    }
    
    public func deactivate(){
        self.layer.borderWidth = 1.5
        self.layer.borderColor = .init(gray: 0.5, alpha: 1)
        self.backgroundColor = .clear
        self.isEnabled = false
    }
}
