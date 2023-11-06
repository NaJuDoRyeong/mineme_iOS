
import UIKit

class StickerCollectionViewCell : UICollectionViewCell {
    
    static let cellID = "StickerCollectionViewCell"
    private let view = UIView()
    private let sticker = UIImageView()
    override var isSelected: Bool {
        didSet {
            selected()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        sticker.image = nil
    }
    
    func bind(image: UIImage){
        sticker.image = image
    }
    
    func initAttribute(){
        view.layer.borderColor = .init(red: 0.69, green: 0.69, blue: 0.7, alpha: 1.0)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    func initAutolayout(){
        self.addSubview(view)
        view.addSubview(sticker)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(54)
        }
        
        sticker.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func selected(){
        if isSelected {
            view.backgroundColor = UIColor(named: "butter")
            view.layer.borderWidth = 0
        }else{
            view.backgroundColor = .clear
            view.layer.borderWidth = 1
        }
    }
}
