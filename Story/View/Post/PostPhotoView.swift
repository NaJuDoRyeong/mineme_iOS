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
    
    let viewModel : StoryPostViewModel

    let postButton = UIButton()
    let representButton = UIButton()
    
    var picker = PHPickerViewController(configuration: PHPickerConfiguration())
    var pageControl = UIPageControl()
    
    var representImage = -1
    
    init(viewModel : StoryPostViewModel, image: UIImage? = nil){
        self.viewModel = viewModel
        super.init()
        self.imageView.image = image
        initAttribute()
        initAutolayout()
    }
    
//    init(image: UIImage? = nil){
//        self.imageView.image = image
//        initAttribute()
//        initAutolayout()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAttribute(){
        self.postButton.setImage(UIImage(named: "select-photo"), for: .normal)
        self.representButton.setImage(UIImage(named: "icon-check"), for: .normal)
        self.representButton.tintColor = .white
        self.representButton.isHidden = true
        
//        var configuration = PHPickerConfiguration()
        
        
        ///use when need image file info.
            let photoLibrary = PHPhotoLibrary.shared()
            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

        configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한 //limit selectable image counts
        configuration.filter = .any(of: [.images])
        
        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        pageControl = {
            let pg = UIPageControl()
            pg.numberOfPages = viewModel.images?.count ?? 0
            pg.currentPage = 0
            pg.currentPageIndicatorTintColor = .black
            pg.pageIndicatorTintColor = .lightGray
            pg.addTarget(self, action: #selector(pageChange), for: UIControl.Event.valueChanged)
            return pg
        }()
    }
    
    func initAutolayout(){
        
        [imageView, postButton, representButton, pageControl].forEach { self.addSubview($0) }
        
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
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
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
        if representButton.tintColor == .black {
            representImage = -1
            representButton.tintColor = .white
        }
        else{
            representImage = pageControl.currentPage
            representButton.tintColor = .black
        }
    }
    
    func pageChange(){
        
        guard let data = viewModel.images?[pageControl.currentPage]
        else { return }
        
        
        self.setImage(UIImage(data: data)!)
        if representImage == pageControl.currentPage {
            self.representButton.tintColor = .black
        }
        else{
            representButton.tintColor = .white
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
        
        for result in results {
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self]
                    (image, error) in
                    if let image = image as? UIImage {
                        
                        if let data = image.downscaleTOjpegData(maxBytes: 1_000_000) {
                            if self?.viewModel.images == nil {
                                self?.viewModel.images = [data]
                            }
                            else{
                                self?.viewModel.images?.append(data)
                            }
                            
                            DispatchQueue.main.async {
                                self?.updateImage()
                            }
                        }
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

    func updateImage(){
        pageControl.numberOfPages = viewModel.images?.count ?? 0
        guard let data = viewModel.images?.first else { return }
        self.setImage(UIImage(data: data)!)
    }
    
}

