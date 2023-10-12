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
        view.isPagingEnabled = true
        view.register(ExternalCollectionViewCell.self, forCellWithReuseIdentifier: ExternalCollectionViewCell.identifier)
        
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
//    private lazy var innerCollectionView = {
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = Const.itemSize
//        layout.minimumLineSpacing = Const.itemSpacing
//        layout.minimumInteritemSpacing = 0
//        
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.isScrollEnabled = true
//        view.showsHorizontalScrollIndicator = false
//        view.showsVerticalScrollIndicator = true
//        view.backgroundColor = .clear
//        view.clipsToBounds = true
//        view.isPagingEnabled = false
//        view.delegate = self
//        view.dataSource = self
//        view.register(InnerCollectionViewCell.self, forCellWithReuseIdentifier: InnerCollectionViewCell.identifier)
//        view.contentInsetAdjustmentBehavior = .never
//        view.contentInset = Const.collectionViewContentInset
//        view.decelerationRate = .fast
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setAutoLayout()
//        view.bringSubviewToFront(innerCollectionView)
        print(imageList.count)
    }
    
    
    func setAutoLayout() {
        [externalCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MARK: - 안쪽뷰
//            innerCollectionView.topAnchor.constraint(equalTo: externalCollectionView.topAnchor),
//            innerCollectionView.trailingAnchor.constraint(equalTo: externalCollectionView.trailingAnchor),
//            innerCollectionView.leadingAnchor.constraint(equalTo: externalCollectionView.leadingAnchor),
//            innerCollectionView.widthAnchor.constraint(equalTo: externalCollectionView.widthAnchor),
//            innerCollectionView.heightAnchor.constraint(equalTo: externalCollectionView.widthAnchor),
            // MARK: - 바깥뷰
            externalCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            externalCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            externalCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            externalCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)

        ])
    }
    
    
}
extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
//        case innerCollectionView:
//            return imageList.count
        case externalCollectionView:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let innerCell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: InnerCollectionViewCell.identifier, for: indexPath) as? InnerCollectionViewCell else { return UICollectionViewCell() }
//        innerCell.innerImageView.image = imageList[indexPath.row]
        guard let exterCell = externalCollectionView.dequeueReusableCell(withReuseIdentifier: ExternalCollectionViewCell.identifier, for: indexPath) as? ExternalCollectionViewCell else { return UICollectionViewCell() }
        
        switch collectionView {
//        case innerCollectionView:
//            return innerCell
        case externalCollectionView:
            return exterCell
        default:
            return UICollectionViewCell()
        }
        
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
