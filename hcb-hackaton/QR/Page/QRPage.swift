//
//  QRPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit

final class QRPage: UIViewController {
    
    typealias RootView = QRView
    
    private let rootView = QRView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
