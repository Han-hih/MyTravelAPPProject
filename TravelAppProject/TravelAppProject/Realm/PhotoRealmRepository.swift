//
//  PhotoRealmRepository.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/13.
//

import Foundation
import RealmSwift

protocol PhotoRealmRepositoryType: AnyObject {
    func createItem(_ item: PhotoTable)
}

class PhotoRealmRepository: PhotoRealmRepositoryType {
    
    let realm = try! Realm()

    func createItem(_ item: PhotoTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
}
