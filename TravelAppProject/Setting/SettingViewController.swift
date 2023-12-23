//
//  SettingViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 10/22/23.
//

import UIKit
import SafariServices

class SettingViewController: UIViewController {
    
    
    private let settingTableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
       return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingTableView.delegate = self
        settingTableView.dataSource = self
        setLayout()
    }
   
    func setLayout() {
        view.addSubview(settingTableView)
        settingTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }

}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
                
        if indexPath.row == 0 {
            cell.settingLabel.text = "개발자에게 문의하기"
        } else if indexPath.row == 1 {
            cell.settingLabel.text = "개인정보 처리 방침"
        } else if indexPath.row == 2 {
            cell.settingLabel.text = "오픈소스 라이센스"
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
                return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = SettingMessage()
            self.present(vc, animated: true)
        } else if indexPath.row == 1 {
            guard let url = NSURL(string: "https://glib-attic-2d2.notion.site/a0b9bc53955c4c078af6d33f01be8512?pvs=4") as? URL else { return }
            let urlView: SFSafariViewController = SFSafariViewController(url: url)
            self.present(urlView, animated: true)
        }
        else if indexPath.row == 2 {
            guard let url = NSURL(string: "https://glib-attic-2d2.notion.site/46d406180a8b43ac800483bc6dbb142b?pvs=4") as? URL else { return }
            let urlView: SFSafariViewController = SFSafariViewController(url: url)
            self.present(urlView, animated: true)
        }
        
    }
}
