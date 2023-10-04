//
//  PlanSearchSettingViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/03.
//

import UIKit

class PlanSearchSettingViewController: UIViewController {
    
    let resultTextField = {
        let text = UITextField()
        text.backgroundColor = .lightGray
        text.borderStyle = .line
        text.layer.cornerRadius = 8
        text.clipsToBounds = true
        
        return text
    }()
    
    let memoTextField = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let timeTextField = {
        let field = UITextField()
        field.layer.cornerRadius = 8
        field.backgroundColor = .lightGray
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setAutoLayout()
        setupDatePicker()
        
        
    }
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        timeTextField.inputView = datePicker
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
        [resultTextField, memoTextField, timeTextField].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                // MARK: - 장소 제목 텍스트필드
                resultTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                resultTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                resultTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                // MARK: - 시간 선택 필드
                timeTextField.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 20),
                timeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                timeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

                // MARK: - 메모 텍스트뷰
                memoTextField.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 20),
                memoTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                memoTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                memoTextField.heightAnchor.constraint(equalToConstant: 200),
                

            ])
        
    }
    
    
    
}
