//
//  MapPinCollectionviewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/14.
//

import UIKit

class MapPinCollectionviewCell: UICollectionViewCell {
    
    let dateLabel = {
        let label = UILabel()
        label.text = "14일(금)"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
