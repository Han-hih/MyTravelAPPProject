//
//  PlanSearchSettingViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/03.
//

import UIKit
import RealmSwift

class PlanSearchSettingViewController: UIViewController {
    
    let resultTextField = {
        let text = UITextField()
        
        return text
    }()
    
    let memoTextField = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let timeTextField = {
        let field = UITextField()
        return field
    }()
    
    let addButton = {
        let button = UIButton()
        button.setTitle("장소 추가하기", for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    var longitude = 0.0
    var latitude = 0.0
    var sectionNumber = 0

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        func setBottomLine(textField: UITextField) {
            let bottomLine = CALayer()
            bottomLine.frame = CGRectMake(0.0, textField.frame.height + 1, textField.frame.width, 1.0)
            bottomLine.backgroundColor = UIColor.black.cgColor
            textField.borderStyle = .none
            textField.layer.addSublayer(bottomLine)
        }
            setBottomLine(textField: resultTextField)
        setBottomLine(textField: timeTextField)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setAutoLayout()
        setupDatePicker()
        
        
    }
    
    @objc func addButtonTapped() {
        realmCreate()
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    
    }
    
    func realmCreate() {
        let realm = try! Realm()
        let task = DetailTable(section: sectionNumber, location: resultTextField.text!, memo: memoTextField.text ?? "", time: timeTextField.text ?? "", longitude: longitude, latitude: latitude)
        try! realm.write {
            realm.add(task)
            
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en-US".localized)
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        datePicker.sizeToFit()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTapped))
        toolbar.setItems([cancelButton, flexibleSpace ,doneButton], animated: true)
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = datePicker
    }
    @objc func cancelButtonTapped() {
        self.view.endEditing(true)
        timeTextField.text = ""
        
    }
    @objc func doneButtonPressed() {
//        timeTextField.text =
        self.view.endEditing(true)
    }
    @objc func dateChange(_ sender: UIDatePicker) {
        timeTextField.text = timeFormatter(time: sender.date)
    }
    
    func timeFormatter(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH : mm"
        return formatter.string(from: time)
    }
    func setAutoLayout() {
        [resultTextField, memoTextField, timeTextField, addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                // MARK: - 장소 제목 텍스트필드
                resultTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                resultTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                resultTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                // MARK: - 시간 선택 필드
                timeTextField.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 40),
                timeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                timeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

                // MARK: - 메모 텍스트뷰
                memoTextField.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 40),
                memoTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                memoTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                memoTextField.heightAnchor.constraint(equalToConstant: 100),
                // MARK: - 장소 추가 버튼
                addButton.topAnchor.constraint(equalTo: memoTextField.bottomAnchor, constant: 40),
                addButton.leadingAnchor.constraint(equalTo: memoTextField.leadingAnchor),
                addButton.trailingAnchor.constraint(equalTo: memoTextField.trailingAnchor),
                addButton.heightAnchor.constraint(equalToConstant: 50)


            ])
        
    }
    
    
    
}
