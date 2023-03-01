//
//  StoryPostWriteContentView.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import PhotosUI

class StoryPostWriteContentView: UIView {
    
    let storyPostVM : StoryPostViewModel
    
    var dateLabel = UILabel()
    var locationLabel = UILabel()
    var photoBox = PostPhotoView()
    var textView = UITextView()
    
    var disposeBag = DisposeBag()
    
    init(vm: StoryPostViewModel){
        self.storyPostVM = vm
        super.init(frame: .zero)
        initAtrribute()
        initAutolayout()
        bind()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        
        storyPostVM.date
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        storyPostVM.location
            .bind(to: locationLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func initAtrribute(){
        dateLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 17)
            
            return label
        }()
        
        locationLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            
            return label
        }()
        
        textView = {
            let tf = UITextView()
            tf.frame.size.height = 151
            tf.layer.borderWidth = 1
            tf.layer.cornerRadius = 10
            tf.layer.borderColor = UIColor.lightGray.cgColor
            tf.backgroundColor = .clear
            tf.text = "무슨 이야기를 남기고 싶나요?"
            tf.textColor = .lightGray
            tf.font = UIFont.systemFont(ofSize: 14)
//            tf.delegate = self
            tf.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            
            return tf
        }()

    }
    
    func initAutolayout(){
        [dateLabel, locationLabel, photoBox, textView].forEach {
            self.addSubview($0)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.left.equalToSuperview()
            $0.right.equalTo(locationLabel)
        }
        
        photoBox.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(15)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.size.equalTo(photoBox.size.rawValue)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(photoBox.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(210)
        }
        
    }
    
}


