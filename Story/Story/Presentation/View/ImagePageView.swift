//
//  ImagePageView.swift
//  Story
//
//  Created by 김민령 on 2023/03/05.
//

import UIKit
import CommonUI
import PhotosUI

public class ImagePageView: UIView {
    
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    var imageViews = [CustomImageView]()
    
    var images = [UIImage]()
    
    var picker = PHPickerViewController(configuration: PHPickerConfiguration())
    
    public init(){
        super.init(frame: .zero)
        images.append(UIImage(systemName: "person")!)
        images.append(UIImage(systemName: "person.fill")!)
        images.append(UIImage(systemName: "pencil")!)
        initAtrribute()
        initAutolaout()
        self.addContentScrollView()
        self.setPageControl()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initAtrribute(){
        pageControl = {
            let pc = UIPageControl()
            pc.numberOfPages = images.count
            pc.currentPage = 0
            pc.pageIndicatorTintColor = .lightGray
            pc.currentPageIndicatorTintColor = .black
            //            pc.addTarget(self, action: #selector(pageChange), for: .valueChanged)
            return pc
        }()
        
        var configuration = PHPickerConfiguration()
//    이미지 정보를 가지고 올 필요가 있을땐 photolibarary 를 사용해준다. //use when need image file info.
//            let photoLibrary = PHPhotoLibrary.shared()
//            var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

        configuration.selectionLimit = 3 //한번에 가지고 올 이미지 갯수 제한 //limit selectable image counts
        configuration.filter = .any(of: [.images])
        
        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        scrollView.delegate = self
        
    }
    
    func initAutolaout(){
        
        scrollView.isPagingEnabled = true
        
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
}

@objc
extension ImagePageView {
    func pageChange(){
        //        self.setImage(images[pageControl.currentPage])
    }
}

extension ImagePageView : UIScrollViewDelegate {
    
    private func addContentScrollView() {
        
        for i in 0..<images.count {
            let imageView = CustomImageView()
            let xPos = scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.imageView.image = images[i]
            imageView.backgroundColor = .black
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
        
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
        
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
}

extension ImagePageView: PHPickerViewControllerDelegate {
    
    //FIXME: 여러장 로직 추가 안함
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        //        var imgData: Data?
        //        var img: UIImage?
        
        //        var imgFile = PreviewItem()
        
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self) {
                    (image, error) in
                    if let image = image as? UIImage {
                        //                        self.setImage(image)
                        self.images.append(image)
                        DispatchQueue.main.async {
                            
//                            self.updateImage()
                            self.addContentScrollView()
                            self.setPageControl()
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
    
    func updateImage(){
        //        pageControl.numberOfPages = images.count
        //        if images.count > 0 {
        //            self.setImage(images[0])
        //        }
    }
}

