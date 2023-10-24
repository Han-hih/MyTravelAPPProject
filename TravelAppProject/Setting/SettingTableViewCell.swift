//
//  SettingTableViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 10/24/23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    let settingLabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout() {
        contentView.addSubview(settingLabel)
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    
}
