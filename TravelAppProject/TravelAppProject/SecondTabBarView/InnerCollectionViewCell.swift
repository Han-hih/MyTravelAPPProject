//
//  InnerCollectionViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/11.
//

import UIKit

class InnerCollectionViewCell: UICollectionViewCell {
    
    let innerImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(image: nil)
    }
    
    func prepare(image: UIImage?) {
        self.innerImageView.backgroundColor = .systemCyan
    }
    func setAutoLayout() {
        [innerImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MARK: - 사진뷰
            innerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            innerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            innerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            innerImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            

        
        ])
    }
    
}
