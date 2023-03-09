//
//  ContentPreviewCell.swift
//  Story
//
//  Created by 김민령 on 2023/03/09.
//

import UIKit
import CommonUI
import Kingfisher

class ContentPreviewCell: UICollectionViewCell {
    
    static let cellID = "ContentPreviewCell"
    
    var contentID : Int?
    var view = CustomImageView(size: .small)
    var header = UIView()
    var location = UILabel()
    var date = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ content: Content){
        view.imageView.kf.setImage(with: URL(string: content.images.first!))
        location.text = content.location
        date.text = content.date
        contentID = content.id
    }
    
    func initAttribute(){
        view.clipsToBounds = true
        
        header.layer.backgroundColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 0.6).cgColor
        
    }
    
    func initAutolayout(){
        self.addSubview(view)
        
        view.addSubview(header)
        
        [location, date].forEach {
            header.addSubview($0)
        }
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        header.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.left.equalTo(view)
            $0.right.equalTo(view)
            $0.height.equalTo(35)
        }
        
        location.snp.makeConstraints {
            $0.centerY.equalTo(header)
            $0.left.equalTo(header).offset(9)
        }
        
    }
    
}
