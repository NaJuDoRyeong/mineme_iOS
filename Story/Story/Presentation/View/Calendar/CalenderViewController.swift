//
//  CalenderViewController.swift
//  Story
//
//  Created by 김민령 on 2023/03/05.
//

import UIKit
import RxSwift
import Common

class CalendarViewController: UIViewController {
    
    private var header = CommonHeader()
    private var dateButton : CalendarDateButton!
    private var calendarWeeksStackView = UIStackView()
    private var calendarCollectionView : UICollectionView!

    private let viewModel = CalendarViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        print("CalendarViewController viewDidLoad")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        updateDays()
        bind()
    }
    
    func bind(){
        viewModel.posts
            .bind(to: calendarCollectionView.rx.items(cellIdentifier: CalendarCollectionViewCell.cellID, cellType: CalendarCollectionViewCell.self)) { idx,data,cell in
                if let data = data {
                    cell.bind(data.day, data.post?.thumbnail)
                }else{
                    cell.isHidden = true
                }
            }.disposed(by: disposeBag)
    }
    
    func initAttribute(){
        
        header = {
            let header = CommonHeader()
            header.setTitle(string: "캘린더")
            header.rightIcon.setImage(CommonAssets.post, for: .normal)
            header.rightIcon.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
            
            header.leftIcon.setImage(StoryImages.calendarButton.image, for: .normal)
            header.leftIcon.addTarget(self, action: #selector(changeVC), for: .touchUpInside)
            return header
        }()
        
        dateButton = {
            let button = CalendarDateButton(viewModel: viewModel)
            button.setTitleColor(.black, for: .normal)
            button.delegate = self
            return button
        }()
        
        calendarWeeksStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.distribution = .equalSpacing
            return view
        }()
        
        calendarCollectionView = {
            let layer = UICollectionViewFlowLayout()
            layer.minimumInteritemSpacing = 5
            layer.itemSize = CGSize(width: CalendarCollectionViewCell.cellSize, height: CalendarCollectionViewCell.cellSize)
            
            let view = UICollectionView(frame: .zero, collectionViewLayout: layer)
            view.backgroundColor = .clear
            view.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.cellID)
            return view
        }()
        
    }
    
    func initAutolayout(){
        
        [header, dateButton, calendarWeeksStackView, calendarCollectionView]
            .forEach { self.view.addSubview($0) }
        
        for day in DayOfWeek.allCases {
            let label : UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = day.kor
                return label
            }()
            
            calendarWeeksStackView.addArrangedSubview(label)
        }
        
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        dateButton.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(45)
            $0.centerX.equalToSuperview()
        }
        
        calendarWeeksStackView.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(21+20)
            $0.right.equalToSuperview().offset(-21-20)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarWeeksStackView.snp.bottom).offset(12)
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
    func updateDays(_ year: String? = nil, _ month: String? = nil){
        viewModel.updateDays(year, month)
        calendarCollectionView.reloadData()
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

extension CalendarViewController : CalendarDateButtonDelegate {
    func changeDate() {
    }
}
