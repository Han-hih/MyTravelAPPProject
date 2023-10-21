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
   
    
//    @objc func addButtonTapped() {
//        realmCreate()
//        if let viewControllers = self.navigationController?.viewControllers {
//            for viewController in viewControllers {
//                if viewController is PlanViewController {
//                    self.navigationController?.popToViewController(viewController, animated: true)
//                    break
//                }
//            }
//        }
//    }
    
    func realmCreate() {
        let realm = try! Realm()
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        
        let task = DetailTable(date: date, location: resultTextField.text!, memo: memoTextField.text ?? "", time: timeTextField.text ?? "", longitude: longitude, latitude: latitude)
        try! realm.write {
//            realm.add(task)
            main.detail.append(task)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    
    
    
}
