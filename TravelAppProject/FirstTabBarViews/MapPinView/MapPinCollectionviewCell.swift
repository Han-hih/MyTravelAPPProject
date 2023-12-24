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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dateLabel.textColor = .white
                dateLabel.backgroundColor = .black
            } else {
                dateLabel.textColor = .black
                dateLabel.backgroundColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
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
