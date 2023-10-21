//
//  File.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/02.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    
    let placeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
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
        [placeLabel, timeLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            //장소 제목 레이블
            placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            timeLabel.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 5),
            
            
        ])
        
        
        
    }
    
}
