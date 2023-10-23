//
//  PhotoDiaryViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/12.
//

import UIKit
import PhotosUI
import RealmSwift

final class PhotoDiaryViewController: UIViewController, PHPickerViewControllerDelegate {
    
    var id: ObjectId?

    var memoList = [String]()
    var photoList = [UIImage]()
    
    lazy var collectionView = {
        let layout = CustomFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true

        view.register(PhotoDiaryCollectionViewCell.self, forCellWithReuseIdentifier: PhotoDiaryCollectionViewCell.identifier)
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private let pageControl = {
     let page = UIPageControl()
        page.currentPage = 0
        page.currentPageIndicatorTintColor = .black
        page.pageIndicatorTintColor = .systemGray
        return page
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConfiguration()
        setNavigationBar()
        setAutoLayout()
        getImageAndMemo()
     setPageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoList = [String]()
        photoList = [UIImage]()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getImageAndMemo()
        collectionView.reloadData()
        
    }
    func setPageControl() {
        pageControl.numberOfPages = photoList.count
        pageControl.isUserInteractionEnabled = true
        
    }
    func getImageAndMemo() {
        let realm = try! Realm()
        let main = realm.objects(TravelRealmModel.self).where {
                $0._id == id!
            }.first!
        for i in 0..<main.photo.count {
            memoList.append(main.photo[i].photoMemo ?? "")
            photoList.append(loadImageFromDocument(fileName: "\(main.photo[i]._id).jpg"))
        }
    }
    
    
    func setAutoLayout() {
        [collectionView, pageControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.98),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.backButtonTitle = .none
        navigationItem.backBarButtonItem?.tintColor = .black
        
        
    }
    
   @objc func addButtonTapped() {
        let vc = PhotoDiaryDrawViewController()
       vc.id = id
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setConfiguration() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
    }
}
extension PhotoDiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoDiaryCollectionViewCell.identifier, for: indexPath) as? PhotoDiaryCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = photoList[indexPath.item]
        cell.imageView.contentMode = .scaleAspectFit
        cell.memoTextView.text = memoList[indexPath.item]
        
        
        
        
        return cell
    }

}

extension PhotoDiaryViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.view.bounds.width)
      self.pageControl.currentPage = page
    }
}
