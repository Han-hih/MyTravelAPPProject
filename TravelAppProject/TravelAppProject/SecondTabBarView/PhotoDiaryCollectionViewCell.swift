//
//  PhotoDiaryCollectionViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/14.
//

import UIKit

class PhotoDiaryCollectionViewCell: UICollectionViewCell {
    
    
    let totalView = {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let memoLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
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
        [totalView, imageView, memoLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            totalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            totalView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            totalView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            totalView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: totalView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: totalView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: totalView.widthAnchor),
            
            memoLabel.centerXAnchor.constraint(equalTo: totalView.centerXAnchor),
            memoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            memoLabel.widthAnchor.constraint(equalTo: totalView.widthAnchor),
            memoLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor)
        
        ])
    }
    
    
    
}
