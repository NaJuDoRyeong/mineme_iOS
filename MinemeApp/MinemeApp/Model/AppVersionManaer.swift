//
//  FirbaseConnect.swift
//  MinemeApp
//
//  Created by 김민령 on 2023/04/24.
//

import Foundation
import Firebase
import Common

fileprivate enum versionType {
    static let minimum = "ios_minimum_version"
    static let latest = "ios_latest_version"
    static let current = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
}

struct AppVersionManager {
    
    private var remoteConfig : RemoteConfig
    
    init(){
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        //        remoteConfig?.setDefaults(fromPlist: "FireBaseDefaults")
    }
    
    func versionChecking(completaion: @escaping (Bool)->() ) {
        print("⭐️⭐️⭐️ app version checking... ⭐️⭐️⭐️")
        print("current version : \(versionType.current)")
        
        remoteConfig.fetch { status, error in
            if status == .success {
                remoteConfig.activate()
            }
            else{
                print("version checking error : \(error?.localizedDescription)")
                return
            }
            completaion(minimumVersionCheck() && latestVersionCheck())
        }

    }
    
    private func minimumVersionCheck() -> Bool {
        
        if let minimumVersion = remoteConfig[versionType.minimum].stringValue {
            print("minimum version : \(minimumVersion)")
            let minimum = minimumVersion.split(separator: ".").map{ Int($0)! }
            let current = splitCurrentVersion()
            if minimum[1] > current[1] {
                return false
            }
            else if minimum[0] > current[0] {
                return false
            }
        }else {
            print("error : fail to get minimum version")
        }

        return true
    }
    
    private func latestVersionCheck() -> Bool {
        
        if let latestVersion = remoteConfig[versionType.latest].stringValue {
            print("latest version : \(latestVersion)")
            let latest = latestVersion.split(separator: ".").map{ Int($0)! }
            let current = splitCurrentVersion()
            if latest[1] > current[1] {
                return false
            }
            else if latest[0] > current[0] {
                return false
            }
        }else {
            print("error : fail to get minimum version")
        }
    
        return true
    }
    
    private func splitCurrentVersion() -> [Int] {
        return versionType.current.split(separator: ".").map { Int($0)! }
    }

}
