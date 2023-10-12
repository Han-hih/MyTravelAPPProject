//
//  PhotoDiaryDrawViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/12.
//

import UIKit
import PhotosUI

class PhotoDiaryDrawViewController: UIViewController, PHPickerViewControllerDelegate {
    
   private let photoButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
       
       return button
    }()
    
    private let photoView = {
        let view = UIImageView()
        view.backgroundColor = .clear
       
        return view
    }()
    
    private let memoView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
 
    
    @objc func photoButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.photoView.image = image as? UIImage
                }
            }
        } else {
            print("error")
        }
    }
}
