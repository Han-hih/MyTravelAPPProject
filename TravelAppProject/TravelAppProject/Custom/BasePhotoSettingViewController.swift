//
//  BasePhotoSettingViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 10/23/23.
//

import UIKit
import PhotosUI
import RealmSwift

class BasePhotoSettingViewController: UIViewController, PHPickerViewControllerDelegate {
    
     let photoButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        //       button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
     let photoView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor

        return view
    }()
    
     let memoTextFieldView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.isScrollEnabled = true
//                view.text = "메모를 입력해주세요"
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(doneButtonTapped))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        keyboardToolbar.sizeToFit()
        keyboardToolbar.tintColor = UIColor.systemGray
        view.inputAccessoryView = keyboardToolbar
        return view
    }()
    let repository = PhotoRealmRepository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardNotifications()
    }
    @objc func doneButtonTapped() {
        self.view.endEditing(true)
    }
    
  
    func setLayout() {
        photoView.addSubview(photoButton)
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        [photoView, memoTextFieldView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            
            photoButton.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
            photoButton.bottomAnchor.constraint(equalTo: photoView.bottomAnchor),
            photoButton.heightAnchor.constraint(equalToConstant: 100),
            photoButton.widthAnchor.constraint(equalTo: photoButton.heightAnchor),
            
            memoTextFieldView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 30),
            memoTextFieldView.leadingAnchor.constraint(equalTo: photoView.leadingAnchor),
            memoTextFieldView.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
            memoTextFieldView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func photoButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    
    
    func addKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    if let uiimage = image as? UIImage {
                        let downImage = uiimage.downSample(size: self.view.bounds.size)
                    
                        self.photoView.contentMode = .scaleAspectFit
                        self.photoView.image = downImage
                        
                    }
                
                }
            }
        } else {
            print("error")
        }
    }
    
    
    @objc func keyboardWillShow(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)!)
        }
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)!)
        }
    }
}

extension UIImage {
    func downSample(size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let data = self.pngData()! as CFData
        let imageSource = CGImageSourceCreateWithData(data, imageSourceOption)!
        
        let maxPixel = max(size.width, size.height) * scale
        let downSampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ] as CFDictionary
        
        let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!
        
        let newImage = UIImage(cgImage: downSampledImage)
        
        return newImage
    }
    
    
    
}
