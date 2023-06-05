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

public class StoryHomeViewController: UIViewController {
    
    let viewModel = StoryHomeViewModel()
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
        
        viewModel.posts
            .map{ !$0.isEmpty }
            .distinctUntilChanged()
            .bind(to: noImageView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.posts
            .subscribe{ [weak self] _ in self?.contentCollectionView.reloadData() }
            .disposed(by: disposeBag)
    
//        viewModel.observable.bind(to: contentCollectionView.rx.items(cellIdentifier: ContentPreviewCell.cellID, cellType: ContentPreviewCell.self)) { index, content, cell in
//            cell.bind(content)
//        }.disposed(by: disposeBag)
                
        
//        contentCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
//        contentCollectionView.rx.itemSelected.bind { indexPath in
//            self.navigationController?.pushViewController(FeedtableView(), animated: true)
//        }.disposed(by: disposeBag)
    }
    
    func initAttribute(){
        noImageView.image = StoryImages.noStory.image //FIXME: 데이터 오면 로직 설정
        
        header.setTitle(string: "스토리")
        header.rightIcon.setImage(CommonAssets.post, for: .normal)
        header.rightIcon.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
        
        header.leftIcon.setImage(StoryImages.storyButton.image, for: .normal)
        header.leftIcon.addTarget(self, action: #selector(changeVC), for: .touchUpInside)
        
        contentCollectionView = {
            let layer = UICollectionViewFlowLayout()
            layer.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layer.minimumLineSpacing = 16
            
            let view = UICollectionView(frame: .zero, collectionViewLayout: layer)
            view.backgroundColor = .clear
            view.showsVerticalScrollIndicator = false
            view.register(ContentPreviewCell.self, forCellWithReuseIdentifier: ContentPreviewCell.cellID)
            view.register(CustomCollectionViewHeader.self,
                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                          withReuseIdentifier: CustomCollectionViewHeader.headerID)
            view.delegate = self
            view.dataSource = self
            return view
        }()
        
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

extension StoryHomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let section = try? viewModel.posts.value() else { return 0 }
        return section.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) ->
            UICollectionReusableView {
                guard let headerName = try? viewModel.regions.value()[indexPath.section] else { return CustomCollectionViewHeader() }
         switch kind {
            case UICollectionView.elementKindSectionHeader:
             let headerView = contentCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomCollectionViewHeader.headerID, for: indexPath) as! CustomCollectionViewHeader
             headerView.bind(headerName)
                return headerView
            default:
                assert(false)
         }
    }
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let headerName = try? viewModel.regions.value()[section] else { return 0 }
        guard let data = try? viewModel.posts.value()[headerName] else { return 0 }
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: ContentPreviewCell.cellID, for: indexPath) as! ContentPreviewCell
        
        guard let headerName = try? viewModel.regions.value()[indexPath.section] else { return cell }
        guard let data = try? viewModel.posts.value()[headerName]?[indexPath.row] else { return cell }
        
        cell.bind(data)
        return cell
    }
    
    
}
