//
//  LoanProcessView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import SnapKit

final class LoanProcessView: UIView {
    
    private let scrollView = UIScrollView()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleView, monthly, employmentType, familyStatus, placeOfBirth, IDNumber, dateOfIssue, dateOfExpiration, issuedBy, nextButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявка на кредит"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .medium20
        return label
    }()
    
    private let subTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Просим внимательно заполнить данные, \nвсе строки обязательны к заполнению"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .regular14
        return label
    }()
    
    let monthly: RegularTextField = {
        let tf = RegularTextField()
        tf.placeholder = "Ежемесячный доход"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let employmentType: SelectTextField = {
        let tf = SelectTextField()
        tf.placeholder = "Тип занятости"
        return tf
    }()
    
    let familyStatus: SelectTextField = {
        let tf = SelectTextField()
        tf.placeholder = "Семейное положение"
        return tf
    }()
    
    let placeOfBirth: RegularTextField = {
        let tf = RegularTextField()
        tf.placeholder = "Место рождения"
        return tf
    }()
    
    let IDNumber: RegularTextField = {
        let tf = RegularTextField()
        tf.placeholder = "Номер удостоверения"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let dateOfIssue: DateTextField = {
        let tf = DateTextField()
        tf.placeholder = "Дата выдачи удостоверения"
        return tf
    }()
    
    let dateOfExpiration: DateTextField = {
        let tf = DateTextField()
        tf.placeholder = "Действителен до"
        return tf
    }()
    
    let issuedBy: SelectTextField = {
        let tf = SelectTextField()
        tf.placeholder = "Кем выдано"
        return tf
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors.red
        btn.setTitle("Далее", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        monthly.delegate = self
        configureDateOfIssueDatePicker()
        configureDateOfExpirationDatePicker()
    }
}

extension LoanProcessView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        monthly.text = "\(textField.text ?? "") тг"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        monthly.text = ""
    }
}

private extension LoanProcessView {
    
    private func configureDateOfIssueDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dateOfIssue.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDateOfIssueDatePicker), for: .valueChanged)
    }
    
    @objc private func handleDateOfIssueDatePicker(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd.MM.yyyy"
        dateOfIssue.text = dateFormat.string(from: sender.date)
    }
    
    private func configureDateOfExpirationDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dateOfExpiration.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd.MM.yyyy"
        dateOfExpiration.text = dateFormat.string(from: sender.date)
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.size.equalToSuperview()
        }
        scrollView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self).inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        subTitleView.addSubview(subTitleLabel)
        makeConstraints()
    }
    
    func makeConstraints() {
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        subTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
}
