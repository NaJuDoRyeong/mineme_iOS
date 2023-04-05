//
//  CalenderViewController.swift
//  Story
//
//  Created by 김민령 on 2023/03/05.
//

import UIKit
import Common

class CalendarViewController: UIViewController {
    
    let dateFormatter = CommonDateFormatter()
    let header = CommonHeader()
    var dateLabel = UILabel()
    var daysStackView = UIStackView()
    var calendarCollectionView : UICollectionView!

    var days = [Int]()
    
    override func viewDidLoad() {
        print("CalendarViewController viewDidLoad")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        updateDays()
    }
    
    func initAttribute(){
        
        header.setTitle(string: "캘린더")
        header.rightIcon.setImage(CommonAssets.post, for: .normal)
        header.rightIcon.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
        
        header.leftIcon.setImage(StoryImages.calendarButton.image, for: .normal)
        header.leftIcon.addTarget(self, action: #selector(changeVC), for: .touchUpInside)
        
        dateLabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = dateFormatter.todayToString()
            return label
        }()
        
        daysStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.distribution = .equalSpacing
            return view
        }()
        
        calendarCollectionView = {
            let layer = UICollectionViewFlowLayout()
            layer.minimumInteritemSpacing = 5
            
            let view = UICollectionView(frame: .zero, collectionViewLayout: layer)
            view.backgroundColor = .clear
            view.delegate = self
            view.dataSource = self
            view.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.cellID)
            return view
        }()
        
    }
    
    func initAutolayout(){
        
        [header, dateLabel, daysStackView, calendarCollectionView].forEach { self.view.addSubview($0) }
        
        for day in DayOfWeek.allCases {
            let label : UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = day.kor
                return label
            }()
            
            daysStackView.addArrangedSubview(label)
        }
        
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(45)
            $0.centerX.equalToSuperview()
        }
        
        daysStackView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(21+20)
            $0.right.equalToSuperview().offset(-21-20)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(daysStackView.snp.bottom).offset(12)
//            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    deinit {
        print("CalendarViewController deinit")
    }

}

extension CalendarViewController {
    func updateDays(){
//        let removedSubviews = contentStackView.arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
//                    contentStackView.removeArrangedSubview(subview)
//                    return allSubviews + [subview]
//
//        }
        let last = dateFormatter.lastDay(year: "2023", month: "3")!
        let firstDate = dateFormatter.StringToDate("2023-3-\(1)", format: "yyyy-M-d")
        let day = dateFormatter.dayOfTheWeek(date: firstDate!)
        days = Array(repeating: 0, count: day-1)
        for i in 1...last{
            days.append(i)
        }
        
    }
}

@objc
extension CalendarViewController {
    
    func tapPostBtn(){
        let storyPostVC = StoryPostViewController()
        storyPostVC.modalPresentationStyle = .fullScreen
        
        present(storyPostVC, animated: true)
    }
    
    func changeVC(){
        self.navigationController?.popToRootViewController(animated: false)
    }
}

extension CalendarViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.cellID, for: indexPath) as! CalendarCollectionViewCell
        if days[indexPath.row] == 0 {
            cell.isHidden = true
        }
        else{
            cell.bind(day: String(days[indexPath.row]))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 5
        return CGSize(width: width, height: width)
    }
    
}

