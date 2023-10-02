//
//  PlanViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/01.
//

import UIKit

final class PlanViewController: UIViewController {
    
    var sectionCount = 0
    var placeArray = ["서울", "대구", "부산"]
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = 60
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setAutoLayout()
        setupTableView()
    }
    
    func setAutoLayout() {
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "PlanTable")
    }
    
}

extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTable", for: indexPath) as? PlanTableViewCell else {
            return UITableViewCell() }
        cell.backgroundColor = .systemMint
        cell.placeLabel.text = placeArray[indexPath.row]
        return cell
        
        }
    }
    
    

