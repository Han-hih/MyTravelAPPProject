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
        view.backgroundColor = .red
        setNavigation()
    }
    
    func setNavigation() {
        self.navigationItem.title = "여행 목록"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

}

