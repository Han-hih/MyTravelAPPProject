//
//  SearchTable.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/26.
//

import UIKit

class SearchTable: UITableViewCell {
    static let identifier = "SearchTable"
    
    let mainTextLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    let subTextLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = .init(white: 1.0, alpha: 0.1)
        } else {
            self.backgroundColor = .none
        }
    }
    
    func setAutoLayout() {
        addSubview(mainTextLabel)
        addSubview(subTextLabel)
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainTextLabel.heightAnchor.constraint(equalToConstant: 20),
            subTextLabel.bottomAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 20),
            subTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subTextLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
    }
    
    
}
