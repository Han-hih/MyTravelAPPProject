//
//  ViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/25.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setNavigation()
    }
    
    func setNavigation() {
        self.navigationItem.title = "여행 목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.and.outline"), style: .done, target: self, action: #selector(createButtonTapped))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }

    @objc func createButtonTapped() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
    }
    
}

