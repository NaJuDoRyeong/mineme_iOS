//
//  ContentPreviewCell.swift
//  Story
//
//  Created by 김민령 on 2023/03/09.
//

import UIKit
import Common
import Kingfisher

class ContentPreviewCell: UICollectionViewCell {
    
    static let cellID = "ContentPreviewCell"
    
    var view = CustomImageView(size: .small)
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
    
    func bind(_ content: PostPreview){
        view.imageView.kf.setImage(with: URL(string: content.thumbnail)!)
//        location.text = content.location
        date.text = content.date
        self.tag = content.postID
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.imageView.image = nil
        location.text = nil
        date.text = nil
    }
    
    func initAttribute(){
        view.clipsToBounds = true
        
        location = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            return label
        }()
        
        date = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 11)
            label.textColor = .gray
            return label
        }()
        
    }
    
    func initAutolayout(){
        
        [view, location, date].forEach {
            addSubview($0)
        }
        
        view.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.size.equalTo(view.size.rawValue)
        }
        
        location.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom).offset(8.05)
            $0.left.right.equalToSuperview()
        }
        
        date.snp.makeConstraints {
            $0.top.equalTo(location.snp.bottom).offset(2)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
}
