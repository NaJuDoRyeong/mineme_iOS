//
//  CalendarCollectionViewCell.swift
//  Story
//
//  Created by 김민령 on 2023/03/06.
//

import UIKit
import SnapKit
import Kingfisher
import Common

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CalendarCollectionViewCell"
    static let cellSize = ((UIScreen.main.bounds.size.width)/7) - 15
    
    private var view = UIImageView()
    private var dayLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        dayLabel.text = nil
        view.image = StoryImages.calendarCircle.image
        isHidden = false
    }
    
    func initAttribute(){
        view.image = StoryImages.calendarCircle.image
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
    
    func bind(_ day: Int, _ imageURL: String? = nil){
        dayLabel.text = "\(day)"
        if let imageURL = imageURL {
            //FIXME: caching & resize
            let processor = ResizingImageProcessor(referenceSize: CGSize(width: Self.cellSize, height: Self.cellSize)) |> RoundCornerImageProcessor(cornerRadius: Self.cellSize/2) 
            view.kf.setImage(with: URL(string: imageURL)!, options: [.processor(processor)])
        }
    }
    
}
