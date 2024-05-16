//
//  Plan.swift
//  TravelAppProject
//
//  Created by 황인호 on 5/16/24.
//

import Foundation

struct Plan {
	var objectId: ObjectId
	var location: String
	var memo: String?
	var time: String?
	
	init(objectID: ObjectId, location: String, memo: String? = nil, time: String? = nil) {
		self.objectId = objectID
		self.location = location
		self.memo = memo
		self.time = time
	}
	
}
