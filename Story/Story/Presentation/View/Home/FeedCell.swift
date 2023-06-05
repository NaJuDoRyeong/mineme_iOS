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
    var labelStackView = UIStackView()
    var imageBox = CustomImageView(shape: .round)
    var content = UILabel()
    var sticker = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(content: Content) {
        //FIXME: more image loaded
//        imageBox.imageView.image = UIImage(named: content.images[0])
        dateLabel.text = content.date
        locationLabel.text = content.location
        self.content.text = content.text
        if let num = content.sticker {
            setSticker(num)
        }
    }
    
    override func prepareForReuse() {
        imageBox.imageView.image = nil
        dateLabel.text = nil
        locationLabel.text = nil
        content.text = nil
        sticker.image = nil
    }
    
    func initAttribute(){
        backgroundColor = .white
        
        labelStackView.axis = .vertical
        
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
            label.font = UIFont.boldSystemFont(ofSize: 13)
            label.numberOfLines = 0
            
            return label
        }()
        
        sticker.isHidden = true
        
    }
    
    func setSticker(_ num: Int){
        sticker.image = Stickers.sticker(num)
        sticker.sizeToFit()
        sticker.isHidden = false
    }
    
    func initAutolayout(){
        [labelStackView, imageBox, content, sticker].forEach {
            self.addSubview($0)
        }
        
        [locationLabel, dateLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.left.equalToSuperview().offset(21)
        }
        
        sticker.snp.makeConstraints {
            $0.left.equalTo(labelStackView.snp.right).offset(10)
            $0.centerY.equalTo(labelStackView)
        }
        
        imageBox.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(imageBox.size.rawValue)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(imageBox.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview().offset(-44)
        }
        
    }
    
}
