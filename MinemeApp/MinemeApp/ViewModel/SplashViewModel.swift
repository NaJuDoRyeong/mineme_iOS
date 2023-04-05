//
//  SplashViewModel.swift
//  MinemeApp
//
//  Created by 김민령 on 2023/04/04.
//

import Foundation
import UIKit

class SplashViewModel {


    func checkLatestVersion() -> Bool {
        DispatchQueue.global().sync {
            // CFBundleShortVersionString - 릴리즈 혹은 bundle 의 버전.
            guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                  // CFBundleIdentifier - 앱의 bundle ID.
                  let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
                  let url = URL(string: "https://itunes.apple.com/lookup?bundleId=" + bundleID),
                  let data = try? Data(contentsOf: url),
                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
                  let results = jsonData["results"] as? [[String: Any]],
                  results.count > 0,
                  let appStoreVersion = results[0]["version"] as? String
            else { return false }
            
            // 1.0.0 으로 표현되는 버전을 [1,0,0] 으로 처리.
            let currentVersionArray = currentVersion.split(separator: ".").map { $0 }
            let appStoreVersionArray = appStoreVersion.split(separator: ".").map { $0 }
            print("currentVersion : \(currentVersion), appStoreVersion: \(appStoreVersion)")
            
            // [Major].[Minor].[Patch]
            // 앞자리(Major)가 낮으면 업데이트
            if currentVersionArray[0] < appStoreVersionArray[0] {
                return false
            } else {
                // 중간자리(Minor) 낮으면 업데이트
                return currentVersionArray[1] < appStoreVersionArray[1] ? false : true
            }
        }
    }
    
    
}
