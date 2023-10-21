//
//  ViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit
import RealmSwift
class MainViewController: UIViewController {
    let realm = try! Realm()
    var list: Results<TravelRealmModel>!
    
    lazy var collectionView = {
        let layout = CustomFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        
        view.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        collectionView.reloadData()

        list = realm.objects(TravelRealmModel.self).sorted(byKeyPath: "addDate", ascending: false)
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setAutoLayout()
        setNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
    }
    
    func setNavigation() {
        self.navigationItem.title = "Travel List".localized
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.and.outline"), style: .done, target: self, action: #selector(createButtonTapped))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }

    @objc func createButtonTapped() {
        let vc = SearchViewController()
//        let nav = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        vc.title = "Choose a country".localized
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy".localized
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.travelPlaceLabel.text = list[indexPath.row].country
        cell.countryFullLabel.text = list[indexPath.row].countryName
        cell.startDateLabel.text = dateFormatter.string(from: list[indexPath.row].startDate)
        cell.endDateLabel.text = dateFormatter.string(from: list[indexPath.row].endDate ?? list[indexPath.row].startDate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlanViewController()
        
        vc.id = list[indexPath.row]._id
        
        vc.navigationController?.title = list[indexPath.row].country
        vc.navigationItem.backButtonTitle = ""
        vc.dateArray = dateBetween(start: list[indexPath.row].startDate, end: list[indexPath.row].endDate ?? list[indexPath.row].startDate)
        vc.sectionCount = daysBetween(start: list[indexPath.row].startDate, end: list[indexPath.row].endDate ?? list[indexPath.row].startDate)
        print(vc.dateArray, vc.sectionCount)
    
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day! + 1
        
    }
    
    func dateBetween(start: Date, end: Date) -> [Date] {
        if start > end { return [Date]() }
        
        var tempDate = start
        var array = [tempDate]
        
        while tempDate < end {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
}
