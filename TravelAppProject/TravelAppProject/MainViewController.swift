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

