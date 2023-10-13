//
//  CustomFlowLayout.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/12.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = .zero
        minimumInteritemSpacing = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
