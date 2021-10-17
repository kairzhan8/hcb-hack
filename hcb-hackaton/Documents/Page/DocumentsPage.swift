//
//  DocumentsPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class DocumentsPage: UIViewController {
    
    typealias RootView = DocumentsView
    
    private let rootView = DocumentsView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
    }
}
