//
//  FeedCell.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import UIKit
import Common

class FeedCell: UITableViewCell {
    
    static let cellID = "FeedCell"
    
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    var imageBox = CustomImageView(shape: .rect)
    var content = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        backgroundColor = .white
        
        locationLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 17)
            
            return label
        }()
        
        dateLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 12)
            
            return label
        }()
        
        content = {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 0
            
            return label
        }()
        
    }
    
    func initAutolayout(){
        [dateLabel, locationLabel, imageBox, content].forEach {
            self.addSubview($0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.left.equalTo(dateLabel)
            $0.right.equalToSuperview()
        }
        
        imageBox.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.size.equalTo(UIScreen.main.bounds.width)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(imageBox.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(29)
            $0.right.equalToSuperview().offset(29)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
}
