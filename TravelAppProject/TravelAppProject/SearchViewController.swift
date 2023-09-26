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
        setSearchCompleter()
        setSearchBar()
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
    func setSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    func setSearchBar() {
        searchBar.delegate = self
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
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTable", for: indexPath) as? SearchTable else { return UITableViewCell() }
        cell.countryLabel.text = searchResults[indexPath.row].title
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            let country = placeMark.country
//            let countryCode = placeMark.countryCode
            print(country)
            
            let vc = CalanderViewController()
            self.present(vc, animated: true)
            
        }
    }
    
    
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}
extension SearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchTable.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
