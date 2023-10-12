//
//  externalCollectionViewCell.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/11.
//

import UIKit

class ExternalCollectionViewCell: UICollectionViewCell {
    lazy var imageList = [UIImage(systemName: "star"), UIImage(systemName: "star.fill"), UIImage(systemName: "photo"), UIImage(systemName: "pencil"), UIImage(systemName: "pencil.line")]
    
    private let countryName = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.text = "대한민국"
        return label
    }()
    
    private let travelRange = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "2020년 07월 20일 ~ 2020년 07월 25일"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout() {
        let layout = CustomFlowLayout()
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        
        view.register(InnerCollectionViewCell.self, forCellWithReuseIdentifier: InnerCollectionViewCell.identifier)
        [view, countryName, travelRange].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MARK: - innerView
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            // MARK: - 도시이름
            countryName.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            countryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            // MARK: - 여행기간
            travelRange.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 20),
            travelRange.leadingAnchor.constraint(equalTo: countryName.leadingAnchor)
        ])
    }
    
}
extension ExternalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerCollectionViewCell.identifier, for: indexPath) as? InnerCollectionViewCell else { return UICollectionViewCell() }
        cell.innerImageView.image = imageList[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 400)
    }
    
}
