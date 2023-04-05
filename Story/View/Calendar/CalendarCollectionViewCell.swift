//
//  CalendarCollectionViewCell.swift
//  Story
//
//  Created by 김민령 on 2023/03/06.
//

import UIKit
import SnapKit
import Common

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CalendarCollectionViewCell"
    
    var view = UIImageView()
    var dayLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        view.image = StoryAssets.calendarCircle
        dayLabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
    }
    
    func initAutolayout(){
        [view, dayLabel].forEach {
            self.addSubview($0)
        }
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind(day: String){
        dayLabel.text = day
    }
    
}
