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
        modifyButtonSetting()
        navigationSetting()
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
  
        }
    @objc func modifyButtonTapped() {
        realmModify()
        
    }
    
    func realmModify() {
        
    }
    
    func realmDelete() {
        
    }
    
    func navigationSetting() {
        
    }
}
