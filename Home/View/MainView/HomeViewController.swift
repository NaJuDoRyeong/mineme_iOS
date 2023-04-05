//
//  HomeView.swift
//  Home
//
//  Created by 김민령 on 2022/11/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Common

open class HomeViewController : UIViewController {
    
    let viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    private var header = CommonHeader()
    private var coupleTitle = UILabel()
    private var myProfileView = HomeProfileView()
    private var loverProfileView = HomeProfileView()
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
        
        viewModel.request()
        bind()
    }

    func bind(){
        
        viewModel.myProfile.subscribe(onNext: {
            self.myProfileView.bind(data: $0)
        }).disposed(by: disposeBag)
        
        viewModel.loverProfile.subscribe(onNext: {
            self.loverProfileView.bind(data: $0)
        }).disposed(by: disposeBag)
        
        viewModel.coupleTitle
            .bind(to: coupleTitle.rx.text)
            .disposed(by: disposeBag)
    }
    
    func initAttribute(){
        heartImage.image = UIImage(named: "heart")
        
        header.setTitle(string: "만나서 반가워요")
        header.rightIcon.setImage(CommonAssets.setting, for: .normal)
        header.rightIcon.addTarget(self, action: #selector(tapSettingButton), for: .touchUpInside)
        
        line.image = HomeAssets.line
        
        previewComment = {
            let label = UILabel()
            label.text = "No Story..."
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .black
            return label
        }()
        
    }
    
    func initAutolayout(){
        
        self.view.addSubview(header)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        [coupleTitle, settingButton, myProfileView, loverProfileView, heartImage, line, previewComment, previewImage].forEach { self.contentView.addSubview($0) }
        
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
        print("👆 setting button tap")
        self.navigationController?.pushViewController(HomeSettingViewController(), animated: false)
        
    }
}
