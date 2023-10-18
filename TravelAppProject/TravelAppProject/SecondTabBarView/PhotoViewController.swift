//
//  PhotoViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit
import RealmSwift

class PhotoViewController: UIViewController {

    lazy var tableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let realm = try! Realm()
    var list: Results<TravelRealmModel>!
    var id: ObjectId?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        view.backgroundColor = .red
        list = realm.objects(TravelRealmModel.self).sorted(byKeyPath: "addDate", ascending: false)
        setAutoLayout()
       
    }
    
    func setNavigation() {
        self.navigationItem.title = "Photo Diary".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setAutoLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
         
        ])
    }
    
    
}
extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        let startDate = "".mediumLocalizeDate(date: list[indexPath.row].startDate)
        let endDate = "".mediumLocalizeDate(date: list[indexPath.row].endDate ?? list[indexPath.row].startDate)
        cell.countryName.text = list[indexPath.row].countryName
        if list[indexPath.row].startDate == list[indexPath.row].endDate {
            cell.travelRange.text = startDate
        } else {
            cell.travelRange.text = "\(startDate) ~ \(endDate)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoDiaryViewController()
        
        vc.id = list[indexPath.row]._id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
   
}
