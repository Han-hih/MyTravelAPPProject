//
//  SearchViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit
import MapKit

enum Section {
     case search
}

struct Search: Hashable {
    var result: MKLocalSearchCompletion
}


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
    
    var dataSource : UITableViewDiffableDataSource<Section, Search>!
    var snapshot : NSDiffableDataSourceSnapshot<Section, Search>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpAutoLayout()
        setSearchCompleter()
        setSearchBar()
        setupTableView()
        setDataSource()
        
    }
    func setDataSource() {
        
        dataSource = UITableViewDiffableDataSource<Section, Search>(tableView: self.searchTable, cellProvider: { [self] tableView, indexPath, item in
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.attributedText = NSAttributedString(string: searchResults[indexPath.row].title, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
            content.textProperties.alignment = .justified
            cell.contentConfiguration = content

            return cell
        })
        
        
    }
    func snapShot(data: [MKLocalSearchCompletion]) {
       var snapshot = NSDiffableDataSourceSnapshot<Section, Search>()
        let data = data.map { Search.init(result: $0) }
        snapshot.appendSections([.search])
        snapshot.appendItems(data)
        dataSource.apply(snapshot)
    }
    
    func setUpAutoLayout() {
        [searchBar, searchTable].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            //searchBar 오토레이아웃
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
//        searchTable.dataSource = self
//        searchTable.register(SearchTable.self, forCellReuseIdentifier: "SearchTable")
    }
}

extension SearchViewController: UITableViewDelegate /*UITableViewDataSource*/ {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResults.count
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        var content = cell.defaultContentConfiguration()
////        content.text = searchResults[indexPath.row].title
//        content.attributedText = NSAttributedString(string: searchResults[indexPath.row].title, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
//        content.textProperties.alignment = .justified
//        cell.contentConfiguration = content
//
//        return cell
//    }
    
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
            guard let country = placeMark.country else { return }
//            let countryCode = placeMark.countryCode
            print(country)
            
            let vc = CalanderViewController()
            
            vc.modalPresentationStyle = .fullScreen
            vc.title = "여행 기간을 설정해주세요"
            vc.country = country
            self.navigationController?.pushViewController(vc, animated: true)
            
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
        print(completer.results)
        snapShot(data: searchResults)
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
