//
//  PhotoDiaryDrawViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/12.
//

import UIKit
import PhotosUI
import RealmSwift

final class PhotoDiaryDrawViewController: BasePhotoSettingViewController {
    
    let diaryLabel = {
        let label = topTextFieldLabel()
        label.text = "Please keep a diary about your photos.".localized
        return label
    }()
//    let repository = PhotoRealmRepository()
    
    var id: ObjectId?
    var photoId: ObjectId?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
    }
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func saveButtonTapped() {
        let realm = try! Realm()
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        
        let task = PhotoTable(photoMemo: memoTextFieldView.text ?? "")
        print(task._id)
        if photoView.image == nil {
            let alert = UIAlertController(title: "사진을 추가해 주세요", message: .none, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default) { _ in
                print("저장안됨")
            }
            alert.addAction(ok)
            present(alert, animated:  true)
        } else {
            try! realm.write {
                main.photo.append(task)
            }
            self.navigationController?.popViewController(animated: true)
        }
        if photoView.image != nil {
            saveImageToDocument(fileName: "\(task._id).jpg", image: photoView.image!)
        }
        
        
    }
    
}


