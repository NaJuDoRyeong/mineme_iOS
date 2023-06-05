
import UIKit

class CustomCollectionViewHeader : UICollectionReusableView {
    static let headerID = "CustomCollectionViewHeader"
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initAttribute()
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        label.text = nil
    }
    
    func initAttribute(){
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func bind(_ title: String){
        label.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
