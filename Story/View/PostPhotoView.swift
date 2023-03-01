//
//  PostPhotoView.swift
//  Story
//
//  Created by 김민령 on 2023/01/11.
//

import UIKit
import CommonUI
import PhotosUI

class PostPhotoView: CustomImageView {

    let postButton = UIButton()
    let representButton = UIButton()
    
    var picker = PHPickerViewController(configuration: PHPickerConfiguration())
    
    init(image: UIImage? = nil){
        super.init()
        self.imageView.image = image
        initAttribute()
        initAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        self.postButton.setImage(UIImage(named: "select-photo"), for: .normal)
        self.representButton.setImage(UIImage(named: "icon-check"), for: .normal)
        self.representButton.tintColor = .white
        self.representButton.isHidden = true
        
        var configuration = PHPickerConfiguration()
//    이미지 정보를 가지고 올 필요가 있을땐 photolibarary 를 사용해준다. //use when need image file info.
//            let photoLibrary = PHPhotoLibrary.shared()
//            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

        configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한 //limit selectable image counts
        configuration.filter = .any(of: [.images])
        
        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
    }
    
    func initAutolayout(){
        
        [imageView, postButton, representButton].forEach { self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        postButton.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
        
        representButton.snp.makeConstraints {
            $0.top.equalTo(imageView).offset(8)
            $0.right.equalTo(imageView).offset(-11)
        }
    }
    
    func setImage(_ image: UIImage){
        self.imageView.image = image
        self.postButton.isHidden = true
        self.representButton.isHidden = false
        self.representButton.addTarget(self, action: #selector(selectRepresentImage), for: .touchUpInside)
    }

}

@objc
extension PostPhotoView {
    //TODO: select event 추가하기
    func selectRepresentImage(){
        if representButton.tintColor == .white {
            self.representButton.tintColor = .black
        }
        else {
            self.representButton.tintColor = .white
        }
        
    }
}

extension PostPhotoView: PHPickerViewControllerDelegate {
    
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
                        self.setImage(image)
                        
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
