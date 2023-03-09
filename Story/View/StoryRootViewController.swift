//
//  StoryRootViewController.swift
//  Story
//
//  Created by 김민령 on 2023/03/05.
//

import UIKit

public class StoryRootViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.pushViewController(StoryHomeViewController(), animated: false)
    }
}
