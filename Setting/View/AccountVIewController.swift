//
//  AccountVIewController.swift
//  Setting
//
//  Created by 김민령 on 2022/11/29.
//

import UIKit

class AccountVIewController: UIViewController {
    
    private let section = ["계정", "계정관리"]
    private let account = ["나의코드", "상대방코드"]
    private let accountManage = ["계정초기화", "로그아웃", "계정탈퇴"]
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initAttribute(){
        tableView.backgroundColor = .white
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initAutolayout(){
        [tableView].forEach { self.view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension AccountVIewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return account.count
        }else if section == 1{
            return accountManage.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellId, for: indexPath) as! SettingTableViewCell
        
        if indexPath.section == 0{
            cell.initData(text: account[indexPath.row], icon: "")
        }else if indexPath.section == 1{
            cell.initData(text: accountManage[indexPath.row], icon: "")
        }else{
            return cell
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
