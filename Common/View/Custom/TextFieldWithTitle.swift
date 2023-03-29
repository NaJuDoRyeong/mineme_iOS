//
//  TextBoxWithTitle.swift
//  Home
//
//  Created by 김민령 on 2022/11/08.
//

import UIKit

public class TextFieldWithTitle: UIView{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var titleLabel = UILabel()
    private var textBox = UIView()
    public var textField = UITextField()
    
    private var title : String
    var text : String?
    private var textLimit : Int?
    private var placeholder : String?
    
    public init(title: String, textLimit: Int? = nil, placeholder : String? = nil) {
        self.title = title
        self.textLimit = textLimit
        self.placeholder = placeholder
        super.init(frame: .zero)
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        titleLabel = {
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = .black
            return label
        }()
        
        textBox = {
            let field = UIView()
            field.layer.borderWidth = 1
            field.layer.cornerRadius = 10
            field.layer.borderColor = UIColor.lightGray.cgColor
            return field

        }()
        
        textField = {
            let field = UITextField()
            field.placeholder = placeholder
            field.font = UIFont.systemFont(ofSize: 14)
            field.clearButtonMode = .unlessEditing
            field.delegate = self
            return field
        }()
    }
    
    func initAutolayout(){
        
        [titleLabel, textBox, textField].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        textBox.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.height.equalTo(50)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(textBox).offset(13)
            $0.left.equalTo(textBox).offset(15)
            $0.right.equalTo(textBox).offset(-15)
            $0.bottom.equalTo(textBox).offset(-13)
        }
    }
    

}

extension TextFieldWithTitle : UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        print("textFieldDidBeginEditing")
        
    }

//    -> UITextField가 수정이 시작될 때 동작합니다.



    public func textFieldDidEndEditing(_ textField: UITextField){
        print("textFieldDidEndEditing")
        
    }

//    -> UITextField가 수정이 완료되면 동작합니다.



    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

//    -> 키보드에 완료버튼을 눌렀을 시 동작합니다.
    

    
}
