//
//  LoanProcessPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class LoanProcessPage: UIViewController {
    
    typealias RootView = LoanProcessView
    private let rootView = LoanProcessView()
    
    private let employmentTypeDataSource = EmploymentTypePickerDataSource()
    private let employmentTypeDelegate = EmploymentTypePickerDelegate()
    private let employmentTypePickerView = UIPickerView()
    
    private let familyStatusDataSource = FamilyStatusPickerDataSource()
    private let familyStatusDelegate = FamilyStatusPickerDelegate()
    private let familyStatusPickerView = UIPickerView()
    
    private let issuedByDataSource = IssuedByPickerDataSource()
    private let issuedByDelegate = IssuedByPickerDelegate()
    private let issuedByPickerView = UIPickerView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
        dismissPickerView()
    }
}

private extension LoanProcessPage {
    func setupPickers() {
        employmentTypePickerView.delegate = employmentTypeDelegate
        employmentTypePickerView.dataSource = employmentTypeDataSource
        rootView.employmentType.inputView = employmentTypePickerView
        familyStatusPickerView.delegate = familyStatusDelegate
        familyStatusPickerView.dataSource = familyStatusDataSource
        rootView.familyStatus.inputView = familyStatusPickerView
        issuedByPickerView.delegate = issuedByDelegate
        issuedByPickerView.dataSource = issuedByDataSource
        rootView.issuedBy.inputView = issuedByPickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        rootView.employmentType.inputAccessoryView = toolBar
        rootView.familyStatus.inputAccessoryView = toolBar
        rootView.issuedBy.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        rootView.employmentType.text = employmentTypeDelegate.selectedType
        rootView.familyStatus.text = familyStatusDelegate.selectedStatus
        rootView.issuedBy.text = issuedByDelegate.selectedType
        view.endEditing(true)
    }
}
