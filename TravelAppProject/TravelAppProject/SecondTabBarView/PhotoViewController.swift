//
//  PhotoViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private enum Const {
        static let itemSize = CGSize(width: 300, height: 400)
        static let itemSpacing = 24.0
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    lazy var imageList = [UIImage(systemName: "star"), UIImage(systemName: "star.fill"), UIImage(systemName: "photo"), UIImage(systemName: "pencil"), UIImage(systemName: "pencil.line")]
    
    private lazy var externalCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isScrollEnabled = true
        view.isPagingEnabled = false
        view.register(ExternalCollectionViewCell.self, forCellWithReuseIdentifier: ExternalCollectionViewCell.identifier)
        view.decelerationRate = .fast
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    let countryName = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 35, weight: .bold)
       label.text = "대한민국"
       return label
   }()
   
    let travelRange = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 20)
       label.text = "2020년 07월 20일 ~ 2020년 07월 25일"
       return label
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        view.backgroundColor = .red
        setAutoLayout()
        
        print(imageList.count)
    }
    
    func setNavigation() {
        self.navigationItem.title = "Photo Diary".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setAutoLayout() {
        [externalCollectionView, countryName, travelRange].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MARK: - 바깥뷰
            externalCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            externalCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            externalCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            externalCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            // MARK: - 도시이름
            countryName.topAnchor.constraint(equalTo: externalCollectionView.bottomAnchor, constant: -100),
            countryName.leadingAnchor.constraint(equalTo: externalCollectionView.leadingAnchor, constant: 10),
            // MARK: - 여행기간
            travelRange.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 20),
            travelRange.leadingAnchor.constraint(equalTo: countryName.leadingAnchor)
        ])
    }
    
    
}
extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let exterCell = externalCollectionView.dequeueReusableCell(withReuseIdentifier: ExternalCollectionViewCell.identifier, for: indexPath) as? ExternalCollectionViewCell else { return UICollectionViewCell() }
        
   return exterCell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDiaryViewController()
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}
