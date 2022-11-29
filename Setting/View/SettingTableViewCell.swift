//
//  SettingTableViewCell.swift
//  Setting
//
//  Created by 김민령 on 2022/11/29.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    private var icon = UIImageView()
    private var text = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.frame.size.height = 50
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(text: String, icon: String){
        self.text.text = text
        self.icon.image = UIImage(named: icon)
    }
    
    func initAttribute(){
        text.textColor = .black
        text.font = .systemFont(ofSize: 17)
    }
    
    func initAutolayout(){
        
        icon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.centerY.equalToSuperview()
        }
        
        text.snp.makeConstraints {
            $0.leading.equalTo(icon)
            $0.centerY.equalToSuperview()
        }
    }
    
}
