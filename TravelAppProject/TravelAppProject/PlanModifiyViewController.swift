//
//  PlanModifiyViewControlle.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/21.
//

import UIKit
import RealmSwift

class PlanModifiyViewController: BaseSettingViewController {
    
    var id: ObjectId?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        modifyButtonSetting()
        navigationSetting()
        getRealmData()
    }
    
    
    override func locationChanged() {
        if locationTextField.text!.isEmpty {
            resultButton.isEnabled = false
            resultButton.setTitle("Please enter the place".localized, for: .normal)
            resultButton.backgroundColor = .red
        } else {
            resultButton.isEnabled = true
            resultButton.setTitle("Modification".localized, for: .normal)
            resultButton.backgroundColor = .lightGray
        }
    }

    
    
    func modifyButtonSetting() {
        resultButton.setTitle("Modification".localized, for: .normal)
        resultButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
    }
    
    func getRealmData() {
        let data = self.realm.objects(DetailTable.self).where {
                    $0._id == self.id!
                }.first!
                print(data)
        locationTextField.text = data.location
        memoTextField.text = data.memo
        timeTextField.text = data.time
        }
    @objc func modifyButtonTapped() {
        realmModify()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func realmModify() {
        let data = self.realm.objects(DetailTable.self).where {
                    $0._id == self.id!
                }.first!
        try! realm.write {
            data.memo = memoTextField.text
            data.time = timeTextField.text
            data.location = locationTextField.text!
        }
    }
    
    func realmDelete() {
        let data = self.realm.objects(DetailTable.self).where {
                    $0._id == self.id!
                }.first!
       try! realm.write {
           realm.delete(data)
        }
        
    }
    
    func navigationSetting() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "Are you sure you want to delete?".localized, message: .none, preferredStyle: .alert)
        let delete = UIAlertAction(title: "Delete".localized, style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
            self.realmDelete()
        }
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
