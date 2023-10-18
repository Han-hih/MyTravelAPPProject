//
//  SearchViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit
import MapKit




class SearchViewController: UIViewController {
    
    enum Section {
         case search
    }
    
    let countryController = CountryController()
    
    var searchArray = [String]()
    
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
    
    var dataSource : UITableViewDiffableDataSource<Section, CountryController.Country>!
    var snapshot : NSDiffableDataSourceSnapshot<Section, CountryController.Country>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpAutoLayout()
        setSearchBar()
        setupTableView()
        setDataSource()

    }
    
    func setDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, CountryController.Country>(tableView: self.searchTable, cellProvider: { tableView, indexPath, item in
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.attributedText = NSAttributedString(string: item.countryKOR, attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
            content.secondaryAttributedText = NSAttributedString(string: item.countryName, attributes: [.font: UIFont.systemFont(ofSize: 12)])
            content.textProperties.alignment = .justified
            cell.contentConfiguration = content
            
            return cell
        })
        
        
    }
    func performQuery(with filter: String?) {
        let countries = countryController.filteredCountries(with: filter).sorted { $0.countryName < $1.countryName }
        var snapshot = NSDiffableDataSourceSnapshot<Section, CountryController.Country>()
        snapshot.appendSections([.search])
        snapshot.appendItems(countries)
        
        dataSource.apply(snapshot, animatingDifferences: true)
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
    
    
    func setSearchBar() {
        searchBar.delegate = self
    }
    
    func setupTableView() {
        searchTable.delegate = self
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let code = item.countryCode
        let countryName = item.countryKOR
        print(code)
        
            let vc = CalanderViewController()
            
            vc.modalPresentationStyle = .fullScreen
            vc.title = "여행 기간을 설정해주세요"
            vc.country = code
        vc.countryName = countryName
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
