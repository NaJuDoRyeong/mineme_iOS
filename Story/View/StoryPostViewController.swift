//
//  SotryPostViewController.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import CommonUI
import UIKit
import SnapKit
import PhotosUI

open class StoryPostViewController: UIViewController {
    
    private var datePicker = StoryDatePicker()
    private var photoBox = PostPhotoView()
    private var textField = UITextField()
//    private var location = LocationSelector()
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initAttribute()
        initAutolayout()
        // Do any additional setup after loading the view.
    }
    
    func initAttribute(){
        
        textField = {
          let tf = UITextField()
            tf.frame.size.height = 151
            tf.placeholder = "내용을 입력하세요"
            tf.layer.borderWidth = 1
            tf.layer.cornerRadius = 10
            tf.layer.borderColor = UIColor.lightGray.cgColor
            tf.font = UIFont.systemFont(ofSize: 14)
            
            return tf
        }()
        
        photoBox.postButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        
    }
    
    func initAutolayout(){
        [photoBox, datePicker, textField].forEach {
            self.view.addSubview($0)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview().offset(121)
            $0.left.equalToSuperview().offset(27)
        }
        
        photoBox.snp.makeConstraints {
            $0.top.equalToSuperview().offset(156)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(photoBox.size.rawValue)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(photoBox.snp.bottom).offset(12)
            $0.left.equalTo(photoBox)
            $0.right.equalTo(photoBox)
            $0.height.equalTo(151)
        }
        

    }

}

extension StoryPostViewController: PHPickerViewControllerDelegate {
    
    @objc func pickImage(){
        
            var configuration = PHPickerConfiguration()
//    이미지 정보를 가지고 올 필요가 있을땐 photolibarary 를 사용해준다. //use when need image file info.
//            let photoLibrary = PHPhotoLibrary.shared()
//            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

            configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한 //limit selectable image counts
            configuration.filter = .any(of: [.images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
    }
    
    
    //FIXME: 여러장 로직 추가 안함
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
                        self.photoBox.setImage(image)
                        
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
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}
