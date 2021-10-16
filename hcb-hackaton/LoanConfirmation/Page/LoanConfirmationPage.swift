//
//  LoanConfirmationPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class LoanConfirmationPage: UIViewController {
    
    typealias RootView = LoanConfirmationView
    
    private let rootView = LoanConfirmationView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
