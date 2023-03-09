//
//  StoryHomeViewController.swift
//  Story
//
//  Created by 김민령 on 2022/11/15.
//

import UIKit
import SnapKit
import CommonUI
import RxSwift
import RxCocoa

public class StoryHomeViewController: UIViewController {
    
    let vc = StoryHomeViewModel()
    let disposeBag = DisposeBag()
    
    private var noImageView = UIImageView()
    var header = CommonHeader()
    var postButton = UIButton()
    var contentCollectionView : UICollectionView!

    open override func viewDidLoad() {
        print("StoryHomeViewController viewDidLoad")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        bind()
        
    }
    
    func bind(){
        vc.observable.bind(onNext: { [weak self] in
            if $0.count != 0 {
                self?.noImageView.isHidden = true
            }
            else{
                self?.noImageView.isHidden = false
            }
        })
        .disposed(by: disposeBag)
        
        vc.observable.bind(to: contentCollectionView.rx.items(cellIdentifier: ContentPreviewCell.cellID, cellType: ContentPreviewCell.self)) { index, content, cell in
            cell.bind(content)
        }.disposed(by: disposeBag)
        
        contentCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        contentCollectionView.rx.itemSelected.bind { indexPath in
            self.navigationController?.pushViewController(FeedtableView(), animated: true)
        }.disposed(by: disposeBag)
    }
    
    func initAttribute(){
        noImageView.image = UIImage(named: "no-image-bread") //FIXME: 데이터 오면 로직 설정
        
        header.setTitle(string: "스토리")
        header.rightIcon.setImage(UIImage(named: "icon-post"), for: .normal)
        header.rightIcon.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
        
        header.leftIcon.setImage(UIImage(named: "story-change"), for: .normal)
        header.leftIcon.addTarget(self, action: #selector(changeVC), for: .touchUpInside)
        
        contentCollectionView = {
            let layer = UICollectionViewFlowLayout()
//            layer.minimumLineSpacing = 16
            
            let view = UICollectionView(frame: .zero, collectionViewLayout: layer)
            view.backgroundColor = .clear
//            view.delegate = self
//            view.dataSource = self
            view.showsVerticalScrollIndicator = false
            view.register(ContentPreviewCell.self, forCellWithReuseIdentifier: ContentPreviewCell.cellID)
            return view
        }()
        
    }
    
    func initAutolayout(){
        self.view.addSubview(noImageView)
        
        [noImageView, header, contentCollectionView].forEach { self.view.addSubview($0) }
        
        header.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        noImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    deinit {
        print("StoryHomeViewController deinit")
    }
}

@objc
extension StoryHomeViewController {
    
    func tapPostBtn(){
        let storyPostVC = StoryPostViewController()
        storyPostVC.modalPresentationStyle = .fullScreen
        
        present(storyPostVC, animated: true)
    }
    
    func changeVC(){
        self.navigationController?.pushViewController(CalendarViewController(), animated: false)
    }
}

extension StoryHomeViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CustomImageView.Size.small.rawValue
        return CGSize(width: size, height: size)
        }
    
}
