//
//  HomeSettingViewController.swift
//  Home
//
//  Created by 김민령 on 2022/11/08.
//

import UIKit
import Common
import Photos
import PhotosUI

public class HomeSettingViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var header = CommonHeader()
    private var profileImage = ProfileImageView()
    private var editImageButton = UIButton()
    private var nameField = TextFieldWithTitle(title: "이름", placeholder: "이름 입력")
    private var coupleNameField = TextFieldWithTitle(title: "커플이름", placeholder: "이름 입력")
    private var loverCommnetField = TextFieldWithTitle(title: "상대 소개글", placeholder: "나의 소개글은 상대가 작성할 수 있어요!")
    private var instaIdField = TextFieldWithTitle(title: "링크", placeholder: "링크 입력")
    private var coupleDay = CustomDatePicker(title: "우리가 만난 날")
    private var birthDay = CustomDatePicker(title: "내 생일")
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func initAttribute() {
        
        header.setTitle(string: "프로필 설정")
        header.leftIcon.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        header.leftIcon.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        
        profileImage.image = UIImage(named: "image-profile")
        
        editImageButton.setImage(UIImage(named: "icon-camera"), for: .normal)
        editImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        
        scrollView.delegate = self
    }
    
    func initAutolayout() {
        
        
        self.view.addSubview(scrollView)
        self.view.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        [profileImage, editImageButton, nameField, coupleNameField, loverCommnetField, instaIdField, coupleDay, birthDay].forEach { contentView.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.centerX.equalToSuperview()
        }
        
        editImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImage).offset(56)
            $0.left.equalTo(profileImage).offset(54)
        }
        
        nameField.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(52)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        coupleNameField.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        loverCommnetField.snp.makeConstraints {
            $0.top.equalTo(coupleNameField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        instaIdField.snp.makeConstraints {
            $0.top.equalTo(loverCommnetField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        coupleDay.snp.makeConstraints {
            $0.top.equalTo(instaIdField.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
        }
        
        birthDay.snp.makeConstraints {
            $0.top.equalTo(coupleDay.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(21)
            $0.right.equalToSuperview().offset(-21)
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        
        
    }

}

@objc
extension HomeSettingViewController {
    func tapBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    func keyboardWillShow(_ noti : NSNotification) {
        if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = frame.cgRectValue
            let height = rect.height //키보드 높이구하기
            
            scrollView.transform = CGAffineTransform(translationX: 0, y: -(height-43))
            

        }
    }

    func keyboardWillHide(_ noti : NSNotification) {
        scrollView.transform = .identity //원래 자리로 돌아가기
    }
    
}

extension HomeSettingViewController{
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension HomeSettingViewController: PHPickerViewControllerDelegate {
    
    @objc func pickImage(){
        
            var configuration = PHPickerConfiguration()
//            이미지 정보를 가지고 올 필요가 있을땐 photolibarary 를 사용해준다. //use when need image file info.
//            let photoLibrary = PHPhotoLibrary.shared()
//            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

            configuration.selectionLimit = 1 //한번에 가지고 올 이미지 갯수 제한 //limit selectable image counts
            configuration.filter = .any(of: [.images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
    }
    
    
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
          
//        var imgData: Data?
//        var img: UIImage?
        
//        var imgFile = PreviewItem()
        
        picker.dismiss(animated: true, completion: nil)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) {
                (image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.profileImage.changeImage(image: image)
                    }
  
                    //이미지의 정보가 필요할때 사용하는 코드
//                    let identifiers = results.compactMap(\.assetIdentifier)
//                    let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)

//                    if let filename = fetchResult.firstObject?.value(forKey: "filename") as? String{
//                       이미지의 이름을 가지고 옴//get image file name
//                    }
                    
                }
            }
        }
       
    }
}


extension HomeSettingViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // 키보드 내리기
            view.endEditing(true)
        }
}
