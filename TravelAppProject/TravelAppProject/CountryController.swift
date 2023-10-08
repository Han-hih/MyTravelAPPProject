//
//  CountryController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/08.
//

import UIKit

class CountryController {
    
    struct Country: Hashable {
        let countryCode: String
        let countryKOR: String
        let countryName: String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: Country, rhs: Country) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return countryKOR.lowercased().contains(lowercasedFilter) || countryName.lowercased().contains(lowercasedFilter)
        }
    }
    func filteredCountries(with filter: String?=nil, limit: Int?=nil) -> [Country] {
        let filtered = countries.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    private lazy var countries: [Country] = {
        return generateCountries()
    }()
}

extension CountryController {
    private func generateCountries() -> [Country] {
        let components = countryRawData.components(separatedBy: CharacterSet.newlines)
        var countires = [Country]()
        for line in components {
            let countryArray = line.components(separatedBy: ",")
            let countryCode = countryArray[0]
            let countryKOR = countryArray[1]
            let countryName = countryArray[2]
            countires.append(Country(countryCode: countryCode, countryKOR: countryKOR, countryName: countryName))
        }
        return countires
    }
}
