//
//  CalanderViewModel.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/01.
//

import Foundation

class CalanderViewModel {
    
    var dateRange = Observable(Date())
    
    func dateToString(completion: @escaping() -> Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy".localized
        
        return dateFormatter.string(from: completion())
//        return ""
    }
}

