//
//  MainPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit

final class MainPage: UIViewController {
    
    typealias RootView = MainView
    
    private let rootView = MainView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = Colors.red
        navigationController?.navigationBar.tintColor = UIColor.black
        rootView.scanButton.addTarget(self, action: #selector(handleScan), for: .touchUpInside)
    }
    
    @objc func handleScan() {
        let vc = QRScanPage()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
