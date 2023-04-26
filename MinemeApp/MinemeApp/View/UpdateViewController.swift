//
//  SplashViewController.swift
//  MinemeApp
//
//  Created by 김민령 on 2023/03/29.
//

import UIKit

class UpdateViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "butter")
        
        let alert = UIAlertController(
            title: "마인미",
            message: "앱 업데이트 후 이용할 수 있어요🥹",
            preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "업데이트", style: .default) { _ in
            //앱스토어로 이동
        }
        
        let endAction = UIAlertAction(title: "종료", style: .destructive) { _ in
            exit(0)
        }
        
        alert.addAction(endAction)
        alert.addAction(updateAction)
        present(alert, animated: true)
    }

}
