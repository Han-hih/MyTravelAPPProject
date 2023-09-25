//
//  SearchViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    private var searchCompleter = MKLocalSearchCompleter() // 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() // 검색 결과를 담는 변수
    
    let searchBar = {
        let bar = UISearchBar()
        bar.becomeFirstResponder()
        bar.showsCancelButton = false
        bar.searchBarStyle = .minimal
        return bar
    }()
    let searchTable = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpAutoLayout()
        setupTableView()
    }
    
 
    func setUpAutoLayout() {
        [searchBar, searchTable].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            //searchBar 오토레이아웃
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //테이블뷰 오토레이아웃
            searchTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupTableView() {
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.register(SearchTable.self, forCellReuseIdentifier: "SearchTable")

    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResults.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTable", for: indexPath) as? SearchTable else { return UITableViewCell() }
        cell.countryLabel.text = "asdfasdfsfdasf"
//        cell.countryLabel.text = searchResults[indexPath.row].title
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}
