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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAutoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func setAutoLayout() {
        [barcodeView, mainView, bottomView].forEach {
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
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
