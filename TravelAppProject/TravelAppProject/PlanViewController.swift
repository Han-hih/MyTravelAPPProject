//
//  PlanViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/01.
//

import UIKit
import RealmSwift

final class PlanViewController: UIViewController {
    
    var id: ObjectId?
    
    let realm = try! Realm()
    var list: Results<TravelRealmModel>!
    
    var appendArr = [String]()
    var sectionCount = 0
    lazy var place = [[Plan]](repeating: [Plan(location: "")], count: sectionCount)
    var dateArray = [Date]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.viewWillDisappear(true)
        tableView.reloadData()
    }
    
    struct Plan {
        var location: String
//        var memo: String?
//        var time: String?
        
        init(location: String) {
            self.location = location
//            self.memo = memo
//            self.time = time
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        list = realm.objects(TravelRealmModel.self)
        view.backgroundColor = .white
        setAutoLayout()
        setupTableView()
        self.tableView.isEditing = true
        print(place)
        planArrayMake()
    }
    func planArrayMake() {
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        
        for i in 0..<sectionCount { // ex) 0과 1을돌고
            for j in 0..<main.detail.count { //ex) detail의 값들을 돌고
                if i == main.detail[j].section { // ex) i와 detail의 section값이 같으면 배열에 추가
                    place[i].append(Plan(location: main.detail[j].location))
                }
            }
            if place[i][0].location == "" {
                place[i].remove(at: 0)
            }
        }
        
        print(place)
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: "PlanTable")
    }
}

extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "".localizeDate(date: dateArray[section])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        //            footerView.backgroundColor = .orange
        let plusButton = UIButton()
        plusButton.setTitle("Add Place".localized, for: .normal)
        plusButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        plusButton.tintColor = .black
        plusButton.tag = section
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
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        let vc = PlanSearchViewController()
        vc.section = sender.tag
        vc.id = id
        present(vc, animated: true)
        print(sender.tag)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    // MARK: - 수정 할 부분(드래그앤드롭)
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //        placeArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        //        let moveObject = self.[sourceIndexPath.row]
        //        placeArray.remove(at: sourceIndexPath.row)
        //        placeArray.insert(moveObject, at: destinationIndexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTable", for: indexPath) as? PlanTableViewCell else {
            return UITableViewCell() }
        cell.placeLabel.text = place[indexPath.section][indexPath.row].location
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
