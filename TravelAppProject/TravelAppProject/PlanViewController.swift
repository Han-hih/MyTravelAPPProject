//
//  PlanViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/01.
//

import UIKit

final class PlanViewController: UIViewController {
    
    var sectionCount = 0
    var placeArray: [String] = ["서울", "대구", "부산"]
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = 60
        return view
    }()
    
    let addButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setAutoLayout()
        setupTableView()
        self.tableView.isEditing = true
    }
    
    func setAutoLayout() {
        [tableView, addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "PlanTable")
    }
    
}

extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
//            footerView.backgroundColor = .orange
        let plusButton = UIButton()
        plusButton.setTitle("Add Place".localized, for: .normal)
        plusButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        plusButton.tintColor = .black
//        plusButton.layer.borderWidth = 1
//        plusButton.layer.borderColor = UIColor.black.cgColor
//        plusButton.layer.cornerRadius = 8
        plusButton.clipsToBounds = true
        plusButton.setTitleColor(UIColor.black, for: .normal)
            plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        plusButton.setUnderline()
            footerView.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
            return footerView

    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    @objc func plusButtonTapped() {
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //        placeArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        let moveObject = self.placeArray[sourceIndexPath.row]
        placeArray.remove(at: sourceIndexPath.row)
        placeArray.insert(moveObject, at: destinationIndexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if placeArray.isEmpty {
            return 1
        } else {
            return placeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTable", for: indexPath) as? PlanTableViewCell else {
            return UITableViewCell() }
        cell.backgroundColor = .systemMint
        if placeArray.isEmpty {
            cell.placeLabel.text = ""
        } else {
            cell.placeLabel.text = placeArray[indexPath.row]
        }
        return cell
        
    }
}



extension UIButton {
    func setUnderline() {
            guard let title = title(for: .normal) else { return }
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: title.count)
            )
            setAttributedTitle(attributedString, for: .normal)
        }
}
