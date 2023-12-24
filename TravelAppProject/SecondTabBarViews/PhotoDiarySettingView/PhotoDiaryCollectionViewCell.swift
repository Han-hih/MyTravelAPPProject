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
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    let memoTextView = {
        let view = UITextView()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.isScrollEnabled = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.isEditable = false
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
        [totalView, imageView, memoTextView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            totalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            totalView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            totalView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            totalView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: totalView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: totalView.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: totalView.widthAnchor),
            
            memoTextView.centerXAnchor.constraint(equalTo: totalView.centerXAnchor),
            memoTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            memoTextView.widthAnchor.constraint(equalTo: totalView.widthAnchor, multiplier: 0.9),
            memoTextView.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -15)
        
        ])
    }
}

