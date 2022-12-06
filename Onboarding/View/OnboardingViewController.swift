//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by 김민령 on 2022/12/06.
//

import UIKit

open class OnboardingViewController: UIViewController {
    
    private var progressBar = UIView()
    private var skipButton = UILabel()
    private var content : [OnboardingData] = []
    private var contentView = UIView()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addContentData()
        initAttribute()
        initAutolayout()
        
    }
    
    func initAttribute(){
        progressBar = {
            let bar = UIView()
            bar.backgroundColor = .lightGray
            bar.frame = CGRect(x: 0, y: 0, width: 230, height: 10)
            bar.layer.cornerRadius = 20
            bar.layer.cornerCurve = .continuous

            return bar
        }()
        
        skipButton = {
            let label = UILabel()
            label.text = "건너뛰기"
            label.font = .systemFont(ofSize: 12)
            label.textColor = .lightGray
            
            return label
        }()
        
        contentView = OnboardingContentView(content: content.first!)
    }
    
    func initAutolayout(){
        [progressBar, skipButton, contentView].forEach {
            self.view.addSubview($0)
        }
        
        progressBar.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalToSuperview().offset(61)
            $0.left.equalToSuperview().offset(80)
            $0.right.equalToSuperview().offset(-80)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerY.equalTo(progressBar)
            $0.left.equalTo(progressBar.snp.right).offset(8)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(progressBar).offset(70)
            $0.left.equalToSuperview().offset(68)
            $0.right.equalToSuperview().offset(-68)
        }
    }
    
    

}

extension OnboardingViewController {
    func addContentData(){
        content.append(OnboardingData(title: "우리의 추억을 소중하고 이쁘게 보관해요", subTitle: "마인미에서 갤러리에 퍼져있는 우리의 사진을 위치별로 기록해요.", imageName: "onboarding-1"))
        
        content.append(OnboardingData(title: "둘만의 소식을 빠르게 전해줄게요", subTitle: "기념일이나 피드 올라온걸 몰라서 곤란하지 않게 마인미가 알려줄게요!", imageName: "onboarding-2"))
        
        content.append(OnboardingData(title: "사랑스러운 사진으로 하루하루 기억해봐요", subTitle: "캘린더를 우리의 사진으로 꾸며서 한 달을 추억으로 가득채워요.", imageName: "onboarding-3"))
    }
}
