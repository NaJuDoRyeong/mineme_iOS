//
//  StoryHomeViewController.swift
//  Story
//
//  Created by 김민령 on 2022/11/15.
//

import UIKit
import SnapKit
import CommonUI

open class StoryHomeViewController: UIViewController {
    
    private var image = UIImageView()
    var header = CommonHeader()
    var postButton = UIButton()

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        
    }
    
    func initAttribute(){
        image.image = UIImage(named: "no-image-bread") //FIXME: 데이터 오면 로직 설정
        
        header.setTitle(string: "스토리")
        header.rightIcon.setImage(UIImage(named: "icon-setting"), for: .normal)
        postButton.setImage(UIImage(named: "icon-post"), for: .normal)
        postButton.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
        
    }
    
    func initAutolayout(){
        self.view.addSubview(image)
        
        header.addSubview(postButton)
        
        postButton.snp.makeConstraints {
            $0.right.equalTo(header.rightIcon.snp.left).offset(-23)
            $0.centerY.equalToSuperview()
        }
        
        [image, header].forEach { self.view.addSubview($0) }
        
        header.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        image.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }

}

@objc
extension StoryHomeViewController {
    
    func tapPostBtn(){
        let storyPostVC = StoryPostViewController()
        storyPostVC.modalPresentationStyle = .fullScreen
        
        present(storyPostVC, animated: true)
    }
}
