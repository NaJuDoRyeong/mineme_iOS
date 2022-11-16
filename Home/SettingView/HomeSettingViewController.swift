//
//  HomeSettingViewController.swift
//  Home
//
//  Created by 김민령 on 2022/11/08.
//

import UIKit
import CommonUI
import Photos
import PhotosUI

open class HomeSettingViewController: UIViewController {
    
    private var profileImage = ProfileImageView(url: "profile-my")
    private var editImageButton = UIButton()
    private var nameField = TextFieldWithTitle(title: "이름", placeholder: "이름 입력")
    private var coupleNameField = TextFieldWithTitle(title: "커플이름", placeholder: "이름 입력")
    private var loverCommnetField = TextFieldWithTitle(title: "상대 소개글", placeholder: "나의 소개글은 상대가 작성할 수 있어요!")
    private var instaIdField = TextFieldWithTitle(title: "링크", placeholder: "링크 입력")
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        // Do any additional setup after loading the view.
    }
    
    func initAttribute() {
        
        self.navigationController?.navigationBar.tintColor = .lightGray
        
        editImageButton.setImage(UIImage(named: "icon-camera"), for: .normal)
        editImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
    }
    
    func initAutolayout() {
        
        [profileImage, editImageButton, nameField, coupleNameField, loverCommnetField, instaIdField].forEach { self.view.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(133)
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
        
    }

}

extension HomeSettingViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension HomeSettingViewController: PHPickerViewControllerDelegate {
    
    @objc func pickImage(){
        
            var configuration = PHPickerConfiguration()
//    이미지 정보를 가지고 올 필요가 있을땐 photolibarary 를 사용해준다. //use when need image file info.
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
