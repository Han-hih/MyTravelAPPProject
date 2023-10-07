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
    
   private let barcodeView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
   private let mainView = {
        let view = UIView()
        //        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        //        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
  private let bottomView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let travelLabel = {
        let label = CustomLabel()
        label.text = "Destination".localized
        return label
    }()
    
    private let startLabel = {
        let label = CustomLabel()
        label.text = "Start Date".localized
        return label
    }()
    
    private let endLabel = {
        let label = CustomLabel()
        label.text = "End Date".localized
        return label
    }()
    
    private let viewLabel = {
        let label = PaddingLabel()
        label.text = " VIEW YOUR PLAN "
        label.font = .boldSystemFont(ofSize: 30)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    let travelPlaceLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "ROK"
        return label
    }()
    
    let startDateLabel = {
        let label = CustomDateLabel()
        return label
    }()
    
    let endDateLabel = {
        let label = CustomDateLabel()
        return label
    }()
    
    let countryFullLabel = {
        let label = UILabel()
        label.text = "UNITED STATES MINOR OUTLYING ISLANDS,United States minor outlying islands"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        
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
        [barcodeView, mainView, bottomView, travelLabel, startLabel, endLabel, viewLabel, travelPlaceLabel, startDateLabel, endDateLabel, countryFullLabel].forEach {
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
            viewLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            travelPlaceLabel.topAnchor.constraint(equalTo: travelLabel.bottomAnchor, constant: 5),
            travelPlaceLabel.leadingAnchor.constraint(equalTo: travelLabel.leadingAnchor),
            
            startDateLabel.topAnchor.constraint(equalTo: travelPlaceLabel.topAnchor),
            startDateLabel.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            
            endDateLabel.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: 5),
            endDateLabel.leadingAnchor.constraint(equalTo: startLabel.leadingAnchor),
            
            countryFullLabel.topAnchor.constraint(equalTo: travelPlaceLabel.bottomAnchor, constant: 2),
            countryFullLabel.leadingAnchor.constraint(equalTo: travelPlaceLabel.leadingAnchor),
            countryFullLabel.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -5)
            
        ])
    }
}

