//
//  String+Extension.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/30.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(number: Int) -> String {
        return StringLiteralType(format: self.localized, number)
    }
    func localizeDate() -> String {
        return DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
    }
    func numbers(money: Int) -> String {
        return NumberFormatter.localizedString(from: money as NSNumber, number: .decimal)
     }
}
