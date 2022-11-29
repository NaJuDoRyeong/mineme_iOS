//
//  SettingTableViewCell.swift
//  Setting
//
//  Created by 김민령 on 2022/11/29.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    static let cellId = "SettingTableViewCell"
    
    var vc : UIViewController?
    
    private var icon = UIImageView()
    private var text = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.frame.size.height = 50
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(vc: UIViewController? = nil, text: String, icon: String){
        self.vc = vc
        self.text.text = text
        self.icon.image = UIImage(systemName: icon)
    }
    
    func initAttribute(){
        text.textColor = .black
        text.font = .systemFont(ofSize: 17)
    }
    
    func initAutolayout(){
        
        [icon, text].forEach { self.addSubview($0) }
        
        icon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.centerY.equalToSuperview()
        }

        text.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(23)
            $0.centerY.equalToSuperview()
        }
    }
    
}
