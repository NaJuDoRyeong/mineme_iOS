//
//  CommonHeader.swift
//  CommonUI
//
//  Created by 김민령 on 2023/02/13.
//

import UIKit

open class CommonHeader : UIView {
    
    var title = UILabel()
    public var leftIcon = UIButton()
    public var rightIcon = UIButton()
    
    public init() {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        initAttribute()
        initAutolayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        backgroundColor = .white
        title = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 24)
            return label
        }()
        
    }
    
    func initAutolayout(){
        
        [title, leftIcon, rightIcon].forEach {
            self.addSubview($0)
        }
        
        [leftIcon, rightIcon].forEach {
            self.bringSubviewToFront($0)
        }
        
        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        leftIcon.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalTo(title)
        }
        
        rightIcon.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalTo(title)
        }
        
        self.snp.makeConstraints {
            $0.width.equalTo(bounds.width)
            $0.height.equalTo(110)
        }
    }
    
    public func setTitle(string: String) {
        title.text = string
    }
    
}
