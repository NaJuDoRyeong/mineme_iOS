import UIKit
import Common


class CalendarDateButton : UIButton {
    
    var delegate : CalendarDateButtonDelegate?
    private let viewModel : CalendarViewModel
    private let pickerView = UIPickerView()
    
    init(viewModel : CalendarViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        dateSetting()
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var inputView: UIView? {
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
}

// MARK: - Obj-C Methods
@objc
extension CalendarDateButton {
    /// Close the picker view
    private func didTapClose(_ button: UIBarButtonItem) {
        resignFirstResponder()
    }
    
    private func didTapDone(_ button: UIBarButtonItem) {
        setTitle()
        delegate?.changeDate()
        resignFirstResponder()
    }
    
    //MARK: - Open the picker view
    private func didTapButton() {
        becomeFirstResponder()
    }
    
}

extension CalendarDateButton {
    
    private func dateSetting() {
        viewModel.dateSetting()
        setTitle()
    }
    
    func setTitle(){
        guard let dateFormat = viewModel.Dateformatting() else { return }
        super.setTitle(dateFormat, for: .normal)
    }
}

extension CalendarDateButton: UIPickerViewDelegate, UIPickerViewDataSource {
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return viewModel.getYears().count
        case 1:
            return viewModel.getMonths().count
        default:
            return 0
        }
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            viewModel.selectYear(row)
        case 1:
            viewModel.selectMonth(row)
        default:
            return
        }
    }
    
    //보여질 데이터
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(viewModel.getYears()[row])"
        case 1:
            return "\(viewModel.getMonths()[row])월"
        default:
            return nil
        }
    }
    
}
