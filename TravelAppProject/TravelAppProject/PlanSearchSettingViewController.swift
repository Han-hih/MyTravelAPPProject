//
//  PlanSearchSettingViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/03.
//

import UIKit
import RealmSwift

class PlanSearchSettingViewController: BaseSettingViewController {
    
    var id: ObjectId?
    var longitude = 0.0
    var latitude = 0.0
    var sectionNumber = 0
    var row = 0
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonSetting()
    }
    func addButtonSetting() {
        resultButton.setTitle("Add Place".localized, for: .normal)
    }
    
    
    func realmCreate() {
        let realm = try! Realm()
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        
        let task = DetailTable(date: date, location: locationTextField.text!, memo: memoTextField.text ?? "", time: timeTextField.text ?? "", longitude: longitude, latitude: latitude)
        try! realm.write {
            //            realm.add(task)
            main.detail.append(task)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    
    
    
}
