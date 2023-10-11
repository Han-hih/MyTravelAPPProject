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
    
    
    
    private lazy var innerCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.isPagingEnabled = false
        view.delegate = self
        view.dataSource = self
        view.register(InnerCollectionViewCell.self, forCellWithReuseIdentifier: InnerCollectionViewCell.identifier)
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = Const.collectionViewContentInset
        view.decelerationRate = .fast
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAutoLayout()
        print(imageList.count)
    }
    
    
    func setAutoLayout() {
        [innerCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            innerCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            innerCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            innerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    
}
extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == innerCollectionView {
            return imageList.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let innerCell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: InnerCollectionViewCell.identifier, for: indexPath) as? InnerCollectionViewCell else { return UICollectionViewCell() }
        innerCell.innerImageView.image = imageList[indexPath.row]
        return innerCell
        
    }
}


extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}
