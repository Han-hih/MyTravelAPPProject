//
//  MainCollectionViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/06.
//

import UIKit
import RealmSwift

class MainCollectionViewCell: UICollectionViewCell {
    static let shared = MainCollectionViewCell()
    
    let barcodeView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let mainView = {
        let view = UIView()
//        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.masksToBounds = true
        view.backgroundColor = .yellow
        return view
    }()
    
    let bottomView = {
        let view = UIView()
                view.layer.borderWidth = 1
                view.layer.borderColor = UIColor.black.cgColor
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let travelLabel = {
        let label = CustomLabel()
        label.text = "여행지"
        return label
    }()
    
    let startLabel = {
        let label = CustomLabel()
        label.text = "Start Date"
        return label
    }()
    
    let endLabel = {
        let label = CustomLabel()
        label.text = "End Date"
        return label
    }()
    
    let viewLabel = {
        let label = PaddingLabel()
        label.text = " VIEW YOUR PLAN "
        label.font = .boldSystemFont(ofSize: 30)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func setAutoLayout() {
        [barcodeView, mainView, bottomView, travelLabel, startLabel, endLabel, viewLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            barcodeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            barcodeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            barcodeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            barcodeView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
            mainView.topAnchor.constraint(equalTo: barcodeView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            bottomView.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             
            travelLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            travelLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            
            startLabel.topAnchor.constraint(equalTo: travelLabel.topAnchor),
            startLabel.leadingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 10),
            
            endLabel.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            endLabel.topAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            viewLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            viewLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
            
        ])
    }
}

