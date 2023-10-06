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
    
    convenience init(country: String, startDate: Date, endDate: Date? = nil) {
        self.init()
        
        self.country = country
        self.startDate = startDate
        self.endDate = endDate
    }
    
    
}

class DetailTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var sequence: Int
    @Persisted var location: String
    @Persisted var memo: String?
    @Persisted var time: String?
    @Persisted var longitude: Double
    @Persisted var latitude: Double
    
    @Persisted(originProperty: "detail") var mainPlan: LinkingObjects<TravelRealmModel>
    
    convenience init(date: Date, sequence: Int, location: String, memo: String? = nil, time: String? = nil, longitude: Double, latitude: Double, mainPlan: LinkingObjects<TravelRealmModel>) {
        self.init()
        
        self.date = date
        self.sequence = sequence
        self.location = location
        self.memo = memo
        self.time = time
        self.longitude = longitude
        self.latitude = latitude
        self.mainPlan = mainPlan
    }
}
