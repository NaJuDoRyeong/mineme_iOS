//
//  OnboardingProgessBar.swift
//  Onboarding
//
//  Created by 김민령 on 2022/12/06.
//

import UIKit

class OnboardingProgessBar: UIView {

    private var progressBarBackground = UIView()
    private var progressBar = UIView()
    private var progressSize = CGFloat()
    private var progressPosition = CGFloat()
    
    init(size: CGFloat){
        self.progressSize = size
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        progressBarBackground = {
            let bar = UIView()
            bar.backgroundColor = .lightGray
            bar.frame = CGRect(x: 0, y: 0, width: 230, height: 10)
            bar.layer.cornerRadius = 5
            bar.layer.cornerCurve = .continuous

            return bar
        }()
        
        progressBar = {
            let bar = UIView()
            bar.backgroundColor = .black
            bar.layer.cornerRadius = 5
            bar.layer.cornerCurve = .continuous
            
            return bar
        }()
    }
    
    func initAutolayout(){
        
        [progressBarBackground, progressBar].forEach {
            self.addSubview($0)
        }
        
        progressBarBackground.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.width.equalTo(progressSize/3)
            $0.left.equalTo(progressBarBackground)
            $0.centerY.equalTo(progressBarBackground)
        }
    }
    
    func updateProgress(){
        progressPosition += (progressSize/3)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [self] in
            self.progressBar.snp.updateConstraints {
                $0.left.equalTo(progressBarBackground).offset(progressPosition)
            }
            
            self.progressBar.superview?.layoutIfNeeded()
        }
    }

}
