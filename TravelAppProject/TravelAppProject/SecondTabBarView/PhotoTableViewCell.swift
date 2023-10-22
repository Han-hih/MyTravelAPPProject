//
//  PhotoTableViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/18.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    var countryName = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    var travelRange = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 20)
       label.text = "2020년 07월 20일 ~ 2020년 07월 25일"
       return label
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAutoLayout() {
        [countryName, travelRange].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            countryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            countryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            travelRange.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 10),
            travelRange.leadingAnchor.constraint(equalTo: countryName.leadingAnchor)
        ])
        
        
    }
}
