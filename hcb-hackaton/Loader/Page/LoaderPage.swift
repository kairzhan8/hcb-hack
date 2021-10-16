//
//  LoaderPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit

final class LoaderPage: UIViewController {
    
    typealias RootView = LoaderView
    
    private let rootView = LoaderView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
