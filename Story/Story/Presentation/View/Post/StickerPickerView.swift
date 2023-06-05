
import UIKit
import SnapKit
import RxSwift

class StickerPickerView : UIView {
    private var title = UILabel()
    private var collectionView : UICollectionView!
    private var descriptionLabel = UILabel()
    
    init(){
        super.init(frame: .zero)
        initAttribute()
        initAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        title = {
            let label = UILabel()
            label.text = "스티커"
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = .black
            return label
        }()
        
        collectionView = {
            let layer = UICollectionViewFlowLayout()
            layer.scrollDirection = .horizontal
            layer.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layer)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.cellID)
            collectionView.delegate = self
            collectionView.dataSource = self
            
            return collectionView
        }()
        
        descriptionLabel = {
            let label = UILabel()
            label.text = "스토리에 귀여운 스티커를 붙여보세요!"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            return label
        }()
    }
    
    func initAutoLayout(){
        [title, collectionView, descriptionLabel].forEach {
            addSubview($0)
        }
        
        title.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(6)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
}


extension StickerPickerView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.cellID, for: indexPath) as! StickerCollectionViewCell
        cell.bind(image: Stickers.stickers[indexPath.row])
        return cell
    }
    
}
