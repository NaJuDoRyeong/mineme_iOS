//
//  StoryHomeViewController.swift
//  Story
//
//  Created by 김민령 on 2022/11/15.
//

import UIKit
import SnapKit
import Common
import RxSwift
import RxCocoa
import ReactorKit

class StoryHomeViewController: UIViewController, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    private var noImageView = UIImageView()
    var header = CommonHeader()
    var postButton = UIButton()
    lazy var contentCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: makeCollectionViewLayout())
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.register(ContentPreviewCell.self,
                      forCellWithReuseIdentifier: ContentPreviewCell.cellID)
        return view
    }()

    open override func viewDidLoad() {
        print("StoryHomeViewController viewDidLoad")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
    }
    
    func bind(reactor: StoryHomeViewReactor) {
        reactor.action.onNext(.initialize)
        
        reactor.state.map(\.postList)
            .distinctUntilChanged()
            .bind(to: contentCollectionView.rx.items(
                cellIdentifier: ContentPreviewCell.cellID,
                cellType: ContentPreviewCell.self)) { index, item, cell in
                    cell.bind(item)
                }.disposed(by: disposeBag)
        
        reactor.state.map(\.postIsEmpty)
            .distinctUntilChanged()
            .map{ !$0 }
            .bind(to: noImageView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func initAttribute(){
        noImageView.image = StoryImages.noStory.image //FIXME: 데이터 오면 로직 설정
        
        header.setTitle(string: "스토리")
        header.rightIcon.setImage(CommonAssets.post, for: .normal)
        header.rightIcon.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
        
        header.leftIcon.setImage(StoryImages.storyButton.image, for: .normal)
        header.leftIcon.addTarget(self, action: #selector(changeVC), for: .touchUpInside)
        
    }
    
    func initAutolayout(){
        self.view.addSubview(noImageView)
        
        [noImageView, header, contentCollectionView].forEach { self.view.addSubview($0) }
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        noImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layer = UICollectionViewFlowLayout()
        layer.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layer.minimumLineSpacing = 16
        return layer
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
