//
//  StoryHomeViewController.swift
//  Story
//
//  Created by 김민령 on 2022/11/15.
//

import UIKit
import SnapKit

open class StoryHomeViewController: UIViewController {
    
    private var image = UIImageView()

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        
    }
    
    func initAttribute(){
        image.image = UIImage(named: "no-image-bread")
    }
    
    func initAutolayout(){
        self.view.addSubview(image)
        
        [image].forEach { self.view.addSubview($0) }
        
        image.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }

}
