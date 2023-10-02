//
//  File.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/02.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    static let identifier = "PlanTable"
    
    let placeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    let addButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        [placeLabel, addButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            //장소 제목 레이블
            placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            //추가버튼
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            
        ])
        
        
        
    }
    
}
