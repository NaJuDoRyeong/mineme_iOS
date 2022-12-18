//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by 김민령 on 2022/12/06.
//

import UIKit
import CommonUI
import CoreLocation

open class OnboardingViewController: UIViewController {
    
    private var progress = OnboardingProgessBar(size: 230)
    
    private var skipButton = UILabel()
    private var content : [OnboardingData] = []
    private var contentView = OnboardingContentView()
    private var nextButton = UIButton()
    
    private var contentNumber = 0
    
    var locationManager : CLLocationManager?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addContentData()
        initAttribute()
        initAutolayout()
    }
    
    func initAttribute(){
        
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
        [progress, skipButton, nextButton, contentView].forEach {
            self.view.addSubview($0)
        }
        
        progress.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalToSuperview().offset(61)
            $0.left.equalToSuperview().offset(80)
            $0.right.equalToSuperview().offset(-80)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerY.equalTo(progress)
            $0.left.equalTo(progress.snp.right).offset(8)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(progress).offset(70)
            $0.left.equalToSuperview().offset(68)
            $0.right.equalToSuperview().offset(-68)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-43)
            $0.centerX.equalToSuperview()
        }
    }
    
    func loadContent(){
        
        self.contentView.initData(content: content[contentNumber])
        progress.updateProgress()
        
        contentView.snp.updateConstraints {
            $0.top.equalTo(progress).offset(70)
            $0.left.equalToSuperview().offset(68)
            $0.right.equalToSuperview().offset(-68)
        }
    }
    
    deinit {
        print("⭕️ deinit OnboardingViewController")
    }

}

extension OnboardingViewController {
    
    @objc func nextContent(){
        print("✅ next button counter : \(contentNumber)")
        contentNumber += 1
        
        // MARK - 권한허용 팝업 부분
        switch contentNumber {
        case 1 :
            locationManager = CLLocationManager()
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
            loadContent()
        case 2 :
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
                if didAllow {
                    print("Push: 권한 허용")
                } else {
                    print("Push: 권한 거부")
                }
            })
            loadContent()
        default:
            OnboardingManager.read()
            self.dismiss(animated: true)
        }
    }
    
    func addContentData(){
        content.append(OnboardingData(title: "우리의 추억을 소중하고 이쁘게 보관해요", subTitle: "마인미에서 갤러리에 퍼져있는 우리의 사진을 위치별로 기록해요.", imageName: "onboarding-1"))
        
        content.append(OnboardingData(title: "둘만의 소식을 빠르게 전해줄게요", subTitle: "기념일이나 피드 올라온걸 몰라서 곤란하지 않게 마인미가 알려줄게요!", imageName: "onboarding-2"))
        
        content.append(OnboardingData(title: "사랑스러운 사진으로 하루하루 기억해봐요", subTitle: "캘린더를 우리의 사진으로 꾸며서 한 달을 추억으로 가득채워요.", imageName: "onboarding-3"))
    }
}
