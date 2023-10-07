//
//  ViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit

class MainViewController: UIViewController {

    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setAutoLayout()
        setNavigation()
    }
    
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    func setNavigation() {
        self.navigationItem.title = "Travel List".localized
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.and.outline"), style: .done, target: self, action: #selector(createButtonTapped))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }

    @objc func createButtonTapped() {
        let vc = SearchViewController()
//        let nav = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        vc.title = "나라 선택"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
