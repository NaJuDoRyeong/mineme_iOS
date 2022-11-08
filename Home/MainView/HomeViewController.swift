//
//  HomeView.swift
//  Home
//
//  Created by 김민령 on 2022/11/05.
//

import UIKit

open class HomeViewController : UIViewController {
    
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
        
        settingButton = {
            let button = UIButton()
//            button.backgroundColor = .black
//            button.frame.size = CGSize(width: 50, height: 50)
            button.setImage(UIImage(named: "icon-setting"), for: .normal)
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
        [settingButton, myProfileView, loverProfileView, heartImage, previewComment, previewImage].forEach { self.view.addSubview($0) }
        
        settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(72)
            $0.right.equalToSuperview().offset(-23)
        }
        
        myProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(144)
            $0.left.equalToSuperview().offset(70)
        }
        
        loverProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(144)
            $0.right.equalToSuperview().offset(-70)
        }
        
        heartImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(233)
            $0.centerX.equalToSuperview()
        }
        
        [line].forEach { self.view.addSubview($0) }
        
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
        }

    }
    
}

extension HomeViewController {
    
    @objc func tapSettingButton(){
        print("setting button tap")
        self.navigationController?.pushViewController(HomeSettingViewController(), animated: false)
        
    }
}
