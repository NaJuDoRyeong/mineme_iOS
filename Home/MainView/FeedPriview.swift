//
//  FeedPriview.swift
//  Home
//
//  Created by 김민령 on 2022/11/09.
//

import UIKit
import CommonUI

class FeedPriview: FeedUIView {
    
    private var postButton : UIButton?
    
    init(image: UIImage? = nil){
        super.init()
        self.imageView.image = image
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        if let _ = self.imageView.image {
            self.imageView.contentMode = .scaleAspectFill
        }
        else{
            self.imageView.image = UIImage(named: "no-image-donut")
            postButton = {
                let button = UIButton()
                button.setTitle("추가하기", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
                button.tintColor = .black
                return button
            }()
        }
    }
    
    func initAutolayout(){
        
        [imageView].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        if let button = postButton {
            
            self.addSubview(button)
            
            button.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-76)
                $0.centerX.equalToSuperview()
            }
        }
        
        
    }
    
}
