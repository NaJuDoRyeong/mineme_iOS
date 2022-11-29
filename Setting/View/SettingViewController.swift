//
//  SettingViewController.swift
//  Setting
//
//  Created by 김민령 on 2022/11/29.
//

import UIKit
import SnapKit

open class SettingViewController: UIViewController {
    
    //FIXME: 수정하기
    let cellData = ["계정", "알림", "보안", "공지사항", "문의하기"]
    
    private var titleText = UILabel()
    private let tableView = UITableView()

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()

        // Do any additional setup after loading the view.
    }
    
    func initAttribute(){
        titleText = {
           let label = UILabel()
            label.text = "설정"
            label.textColor = .black
            label.font = .systemFont(ofSize: 20)
            label.frame.size = CGSize(width: 199, height: 28)
            return label
        }()
        
        tableView.backgroundColor = .white
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initAutolayout(){
        
        [tableView, titleText].forEach { self.view.addSubview($0) }
        
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(68)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).offset(38)
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

}

extension SettingViewController : UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellId, for: indexPath) as! SettingTableViewCell
        cell.initData(vc: AccountVIewController() ,text: cellData[indexPath.row], icon: "person")
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingTableViewCell else { return }
        guard let vc = cell.vc else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
