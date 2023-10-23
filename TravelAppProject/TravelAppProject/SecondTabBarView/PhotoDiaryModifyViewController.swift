//
//  PhotoDiaryModifyViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 10/23/23.
//

import UIKit
import RealmSwift
import PhotosUI

class PhotoDiaryModifyViewController: BasePhotoSettingViewController {
    
    
    var id: ObjectId?
    var photoId: ObjectId?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
    }
      func setNavigationBar() {
            let add = UIBarButtonItem(image: UIImage(systemName: "pencil.line"), style: .plain, target: self, action: #selector(modifyButtonTapped))
          let delete = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(deleteButtonTapped))
          navigationItem.rightBarButtonItems = [add, delete]
            self.navigationController?.navigationBar.tintColor = .black
        }
    func realmModify() {
        //잘됨
        let data = self.realm.objects(PhotoTable.self).where {
                    $0._id == self.photoId!
                }.first!
        let task = PhotoTable(photoMemo: memoTextFieldView.text ?? "")
        try! realm.write {
            data.photoMemo = memoTextFieldView.text
        }
        if task._id != photoId {
            saveImageToDocument(fileName: "\(photoId!).jpg", image: photoView.image!)
        } else {
            print("이미지는 같음")
        }
        self.navigationController?.popViewController(animated: true)
    }
    func realmDelete() {
        let data = self.realm.objects(PhotoTable.self).where {
                    $0._id == self.photoId!
                }.first!
        try! realm.write {
            realm.delete(data)
        }
        removeImageFromDocument(fileName: "\(photoId!).jpg")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func modifyButtonTapped() {
        realmModify()

            
        }
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "Are you sure you want to delete?".localized, message: "Deleted data is not recovered.".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Delete".localized, style: .destructive) {_ in 
            self.realmDelete()
            print("삭제됨")
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

   
    
}
