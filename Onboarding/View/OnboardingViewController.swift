//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by 김민령 on 2022/12/06.
//

import UIKit
import CommonUI

open class OnboardingViewController: UIViewController {
    
    private var progressBarBackground = UIView()
    private var progressBar = UIView()
    private var progressPosition = CGFloat()
    
    private var skipButton = UILabel()
    private var content : [OnboardingData] = []
    private var contentView = OnboardingContentView()
    private var nextButton = UIButton()
    
    private var contentNumber = 0
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addContentData()
        initAttribute()
        initAutolayout()
    }
    
    func initAttribute(){
        progressBarBackground = {
            let bar = UIView()
            bar.backgroundColor = .lightGray
            bar.frame = CGRect(x: 0, y: 0, width: 230, height: 10)
            bar.layer.cornerRadius = 20
            bar.layer.cornerCurve = .continuous

            return bar
        }()
        
        progressBar = {
            let bar = UIView()
            bar.backgroundColor = .black
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
        
        nextButton = {
            let button = CommonButton(text: "다 음")
            button.addTarget(self, action: #selector(nextContent), for: .touchUpInside)
            return button
        }()
        
        contentView.initData(content: content[contentNumber])
    }
    
    func initAutolayout(){
        [progressBarBackground, progressBar, skipButton, nextButton, contentView].forEach {
            self.view.addSubview($0)
        }
        
        progressBarBackground.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalToSuperview().offset(61)
            $0.left.equalToSuperview().offset(80)
            $0.right.equalToSuperview().offset(-80)
        }
        
        progressBar.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.width.equalTo(progressBarBackground.frame.width/3)
            $0.left.equalTo(progressBarBackground)
            $0.centerY.equalTo(progressBarBackground)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerY.equalTo(progressBarBackground)
            $0.left.equalTo(progressBarBackground.snp.right).offset(8)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(progressBarBackground).offset(70)
            $0.left.equalToSuperview().offset(68)
            $0.right.equalToSuperview().offset(-68)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-43)
            $0.centerX.equalToSuperview()
        }
    }
    
    func loadContent(){
        
        contentView.initData(content: content[contentNumber])
        progressPosition += progressBarBackground.frame.width/3
        
        contentView.snp.updateConstraints {
            $0.top.equalTo(progressBarBackground).offset(70)
            $0.left.equalToSuperview().offset(68)
            $0.right.equalToSuperview().offset(-68)
        }
        
        progressBar.snp.updateConstraints {
            $0.left.equalTo(progressBarBackground).offset(progressPosition)
        }
    }

}

extension OnboardingViewController {
    
    @objc func nextContent(){
        print("✅ next button counter : \(contentNumber)")
        contentNumber += 1
        if content.count > contentNumber {
            loadContent()
        }else{
            self.dismiss(animated: true)
        }
    }
    
    func addContentData(){
        content.append(OnboardingData(title: "우리의 추억을 소중하고 이쁘게 보관해요", subTitle: "마인미에서 갤러리에 퍼져있는 우리의 사진을 위치별로 기록해요.", imageName: "onboarding-1"))
        
        content.append(OnboardingData(title: "둘만의 소식을 빠르게 전해줄게요", subTitle: "기념일이나 피드 올라온걸 몰라서 곤란하지 않게 마인미가 알려줄게요!", imageName: "onboarding-2"))
        
        content.append(OnboardingData(title: "사랑스러운 사진으로 하루하루 기억해봐요", subTitle: "캘린더를 우리의 사진으로 꾸며서 한 달을 추억으로 가득채워요.", imageName: "onboarding-3"))
    }
}
