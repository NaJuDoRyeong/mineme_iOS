//
//  FeedtableView.swift
//  Story
//
//  Created by 김민령 on 2023/03/01.
//

import UIKit

open class FeedtableView: UIViewController {
    
    let tableView = UITableView()
    
    open override func viewDidLoad() {
        tableView.register(FeedCell.classForCoder(), forCellReuseIdentifier: FeedCell.cellID)
        initAttribute()
        initAutolayout()
    }
    
    func initAttribute(){
        self.view.backgroundColor = .white
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func initAutolayout(){
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension FeedtableView : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.cellID, for: indexPath) as! FeedCell
        
        let content = Content(id: indexPath.row, location: "프랑스 파리", date: "2022 Oct 1", images: [], text: "너랑 같이 본 첫 에펠탑 \n날씨도 완벽하고 바게트빵도 너무 맛있었지? \n평생 잊지 못할거야 우린 꼭 늙어서 에펠탑이 보이는 곳에서 살자", sticker: Int.random(in: 1...9))
        cell.bind(content: content)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
