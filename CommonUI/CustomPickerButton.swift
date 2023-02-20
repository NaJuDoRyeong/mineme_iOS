//
//  CustomPickerButton.swift
//  CommonUI
//
//  Created by 김민령 on 2022/12/21.
//

import UIKit
import SnapKit
import RxSwift

public class CustomPickerButton: UIButton {
    
    
    // MARK: - UI setting
    private var uiView = UIView()
    private var label = UILabel()
    private var btn = UIImageView()
    
    var observable = PublishSubject<String>()
    
    private func initAttribute(placeholder : String){
        
        uiView = {
            let uiView = UIView()
            uiView.layer.borderWidth = 1
            uiView.layer.cornerRadius = 10
            uiView.layer.borderColor = UIColor.lightGray.cgColor
            
            return uiView
        }()
        
        label = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .lightGray
            label.text = placeholder
            
            return label
        }()
        
        btn.image = UIImage(named: "btn-bottom")
        btn.sizeToFit()
        
    }
    
    private func initAutolayout(width: CGFloat){
        
        [uiView, label, btn].forEach {
            self.addSubview($0)
        }
        
        uiView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(50)
        }
        
        label.snp.makeConstraints {
            $0.left.equalTo(uiView).offset(34)
            $0.centerY.equalToSuperview()
        }
        
        btn.snp.makeConstraints {
            $0.right.equalTo(uiView).offset(-11)
            $0.centerY.equalToSuperview()
        }
        
        uiView.isUserInteractionEnabled = false
        label.isUserInteractionEnabled = false
        btn.isUserInteractionEnabled = false
    }
    
    private var data : [String]?

    /// public init - 외부 호출
    public init(placeholder : String, width: CGFloat){
        super.init(frame: .zero)
        initAttribute(placeholder: placeholder)
        initAutolayout(width: width)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PickerView & inputView setting
    private let pickerView = UIPickerView()

    // inputView안에 pickerView 띄움
    public override var inputView: UIView? {
        return pickerView
    }
    
    // inputView의 악세사리 (inputView 상단 취소, 완료)
    public override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 40)
        
        let closeButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didTapClose(_:))
        )
        closeButton.tintColor = UIColor(named: "butter")
        
        let space = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(didTapDone(_:))
        )
        
        doneButton.tintColor = UIColor(named: "butter")
        let items = [closeButton, space, doneButton]
        toolbar.setItems(items, animated: false)
        toolbar.sizeToFit()

        return toolbar
    }
    
    //이벤트 받는 첫번째 responder로 지정
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Public Methods (먼지 몰라서 일단 죽임)
//    public func reloadData() {
//        pickerView.reloadAllComponents()
//    }
    
    private func configureView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
}

// MARK: - Obj-C Methods
@objc
extension CustomPickerButton {
    /// Close the picker view
    private func didTapClose(_ button: UIBarButtonItem) {
        resignFirstResponder()
    }
    
    private func didTapDone(_ button: UIBarButtonItem) {
        resignFirstResponder()
    }
    
    //MARK: - Open the picker view
    private func didTapButton() {
        print("CustomPickerButton: button Tap")
        becomeFirstResponder()
    }
    
}

extension CustomPickerButton {
    
    func getData() -> String? {
        return label.text
    }
    
    func setData(data: [String]){
        self.data = data
    }
}

extension CustomPickerButton : UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data?[row]
    }
    
    //data 선택시 동작할 event
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = data?[row]
        observable.onNext(data?[row] ?? "")
    }
    
//    public func pickerView(_ pickerView: UIPickerView, titleForRow: Int) {
//        print("Done Button Detected", data[titleForRow])
//    }
}
