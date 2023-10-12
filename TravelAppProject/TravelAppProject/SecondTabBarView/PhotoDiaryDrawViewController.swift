//
//  PhotoDiaryDrawViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/12.
//

import UIKit
import PhotosUI

final class PhotoDiaryDrawViewController: UIViewController, PHPickerViewControllerDelegate {
    
   private let photoButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
       button.setTitleColor(.black, for: .normal)
       return button
    }()
    
    private let photoView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
//        view.layer.cornerRadius = 20
//        view.clipsToBounds = true
        return view
    }()
    
    private let memoTextFieldView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(doneButtonTapped))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        keyboardToolbar.sizeToFit()
        keyboardToolbar.tintColor = UIColor.systemGray
        view.inputAccessoryView = keyboardToolbar
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        setNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    @objc func doneButtonTapped() {
        self.view.endEditing(true)
    }
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    @objc func saveButtonTapped() {
        
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
            photoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 1),
            
            photoButton.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
            photoButton.bottomAnchor.constraint(equalTo: photoView.bottomAnchor),
            photoButton.heightAnchor.constraint(equalToConstant: 50),
            photoButton.widthAnchor.constraint(equalTo: photoButton.heightAnchor),
            
            memoTextFieldView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 30),
            memoTextFieldView.leadingAnchor.constraint(equalTo: photoView.leadingAnchor),
            memoTextFieldView.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
            memoTextFieldView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
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
                    self.photoView.contentMode = .scaleAspectFit
                }
            }
        } else {
            print("error")
        }
    }
    
    func addKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
