//
//  RealmModel.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/05.
//

import Foundation
import RealmSwift

class TravelRealmModel: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var country: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date?
    @Persisted var detail: List<DetailTable>
    @Persisted var photo: List<PhotoTable>
    
    convenience init(country: String, startDate: Date, endDate: Date? = nil) {
        self.init()
        
        self.country = country
        self.startDate = startDate
        self.endDate = endDate
    }
    
    
}

class DetailTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var section: Int
    @Persisted var location: String
    @Persisted var memo: String?
    @Persisted var time: String?
    @Persisted var longitude: Double
    @Persisted var latitude: Double
    
    @Persisted(originProperty: "detail") var mainPlan: LinkingObjects<TravelRealmModel>
    
    convenience init(section: Int, location: String, memo: String? = nil, time: String? = nil, longitude: Double, latitude: Double) {
        self.init()
        
        self.section = section
        self.location = location
        self.memo = memo
        self.time = time
        self.longitude = longitude
        self.latitude = latitude
    }
}

class PhotoTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var photo: Data
    @Persisted var photoMemo: String?
    
    @Persisted(originProperty: "photo") var photoDiary: LinkingObjects<TravelRealmModel>
    
    convenience init(photo: Data, photoMemo: String? = nil) {
        self.init()
        
        self.photo = photo
        self.photoMemo = photoMemo
    }
}
