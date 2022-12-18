//
//  OnboardingManager.swift
//  Onboarding
//
//  Created by 김민령 on 2022/12/18.
//

import Foundation

public struct OnboardingManager {
    static let key = "onboarding"
    
    public init(){}
    
    public func isRead() -> OnboardingViewController? {
        if UserDefaults.standard.bool(forKey: OnboardingManager.key) {
            return nil
        }
        else{
            return OnboardingViewController()
        }
    }
    
    static func read() {
        UserDefaults.standard.set(true, forKey: OnboardingManager.key)
    }
}
