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
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(touched))
        self.view.addGestureRecognizer(tapgesture)
    }
    
    @objc func touched() {
        let vc = SuccessPage()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
