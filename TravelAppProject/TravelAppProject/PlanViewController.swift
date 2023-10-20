//
//  PlanViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/01.
//

import UIKit
import RealmSwift

final class PlanViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var id: ObjectId?
    
    let realm = try! Realm()
    var list: Results<TravelRealmModel>!
    var sortedData: [[DetailTable]] = []
    
    var appendArr = [String]()
    var sectionCount = 0
    lazy var place = [[Plan]](repeating: [], count: sectionCount)
    var dateArray = [Date]()
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = 60
        return view
    }()
    
    let naviButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        place = [[Plan]](repeating: [Plan(objectID: id!, location: "", memo: "", time: "")], count: sectionCount)
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSortedData()
        tableView.reloadData()
                    
    }
    
    struct Plan {
        var objectId: ObjectId
        var location: String
        var memo: String?
        var time: String?
        
        init(objectID: ObjectId, location: String, memo: String? = nil, time: String? = nil) {
            self.objectId = objectID
            self.location = location
            self.memo = memo
            self.time = time
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = realm.objects(TravelRealmModel.self)
        view.backgroundColor = .white
        setNavigation()
        setAutoLayout()
        setSortedData()
        setupTableView()
        
        
    }
    func setSortedData() {
        // 날짜 기준으로 하나의 Array 만들어서 sortedData 추가
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        place = [[Plan]](repeating: [], count: sectionCount)
        for i in 0..<sectionCount {
            for j in 0..<main.detail.count {
                if dateArray[i] == main.detail[j].date {
                    place[i].append(Plan(objectID: main.detail[j]._id, location: main.detail[j].location))
                }
            }
            
        }
    }
    
    func setData() {
        let main = realm.objects(TravelRealmModel.self).where {
            $0._id == id!
        }.first!
        place = [[Plan]](repeating: [], count: sectionCount)
        print(sectionCount, main.detail.count)
        for i in 0..<sectionCount {
            for j in 0..<main.detail.count {
                if dateArray[i] == main.detail[j].date {
                    place[i].append(Plan(objectID: main.detail[j]._id, location: main.detail[j].location))
                }
            }

        }
    }

    func setNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    @objc func mapButtonTapped() {
        let vc = MapPinViewController()
        vc.sectionCount = sectionCount
        vc.dateArray = dateArray
        vc.id = id
        navigationController?.pushViewController(vc, animated: true)
    }
    func setAutoLayout() {
        [tableView, naviButton].forEach {
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
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: PlanTableViewCell.identifier)
    }
}

extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "".localizeDate(date: dateArray[section])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        let plusButton = UIButton()
        plusButton.setTitle("Add Place".localized, for: .normal)
        plusButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        plusButton.tintColor = .black
        plusButton.tag = section
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
        vc.id = id
        vc.date = dateArray[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let main = self.realm.objects(TravelRealmModel.self).where {
            $0._id == self.id!
        }.first!
        print(main)
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
                print(main.detail.count)
                for i in 0..<main.detail.count {
                    guard let task = self.realm.objects(DetailTable.self).filter({ $0._id == main.detail[i]._id }).first else { return }
                    if self.place[indexPath.section][indexPath.row].objectId == main.detail[i]._id {
                        try! self.realm.write {
                            self.realm.delete(task)
                        }

                    }
                }

            // 테이블 뷰에서 해당 셀 삭제
            self.setData()
//            tableView.deleteRows(at: [indexPathToDelete], with: .automatic)
            
            print(self.place)
            tableView.reloadData()


            print("삭제 클릭됨")
            completionHandler(true)
            
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.identifier, for: indexPath) as? PlanTableViewCell else {
            return UITableViewCell() }
        cell.selectionStyle = .none
        
        
        cell.placeLabel.text = place[indexPath.section][indexPath.row].location
        
        cell.memoButton.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
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
