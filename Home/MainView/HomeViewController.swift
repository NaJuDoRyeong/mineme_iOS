//
//  HomeView.swift
//  Home
//
//  Created by 김민령 on 2022/11/05.
//

import UIKit
import SnapKit

open class HomeViewController : UIViewController {
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    
    private var coupleTitle = UILabel()
    private var myProfileView = HomeProfileView(Profile(name: "아무개", image: "profile-my"))
    private var loverProfileView = HomeProfileView(Profile(name: "아무개", image: "profile-lover"))
    private var heartImage = UIImageView()
    private var settingButton = UIButton()
    private var line = UIImageView()
    private var previewComment = UILabel()
    private var previewImage = FeedPriview()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
    }
    
    func initAttribute(){
        heartImage.image = UIImage(named: "heart")
        
        coupleTitle = {
            let label = UILabel()
            label.textColor = .black
            label.text = "만나서 반가워요"
            label.font = UIFont.systemFont(ofSize: 24)
            return label
        }()
        
        settingButton = {
            let button = UIButton()
            //FIXME: button 클릭이 안됨 ㅠㅠ
            button.backgroundColor = .black
            button.frame.size = CGSize(width: 50, height: 50)
            //            button.setImage(UIImage(named: "icon-setting"), for: .normal)
            button.addTarget(self, action: #selector(tapSettingButton), for: .touchUpInside)
            
            return button
        }()
        
        line.image = UIImage(named: "line")
        
        previewComment = {
            let label = UILabel()
            label.text = "No Story..."
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .black
            return label
        }()
        
    }
    
    func initAutolayout(){
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        [coupleTitle, settingButton, myProfileView, loverProfileView, heartImage, line, previewComment, previewImage].forEach { self.contentView.addSubview($0) }
        
        coupleTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalTo(coupleTitle)
            $0.right.equalToSuperview().offset(-23)
        }
        
        myProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(92)
            $0.left.equalToSuperview().offset(70)
        }
        
        loverProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(92)
            $0.right.equalToSuperview().offset(-70)
        }
        
        heartImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(181)
            $0.centerX.equalToSuperview()
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(heartImage).offset(152)
            $0.centerX.equalToSuperview()
        }
        
        previewComment.snp.makeConstraints {
            $0.top.equalTo(line).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        previewImage.snp.makeConstraints {
            $0.top.equalTo(previewComment.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(previewImage.size.rawValue)
            //FIXME: change
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        scrollView.sizeToFit()
    }
    
}

extension HomeViewController {
    
    @objc func tapSettingButton(){
        print("setting button tap")
        self.navigationController?.pushViewController(HomeSettingViewController(), animated: false)
        
    }
}
