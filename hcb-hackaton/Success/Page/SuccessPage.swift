//
//  SuccessPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit
import SwiftEntryKit

final class SuccessPage: UIViewController {
    
    typealias RootView = SuccessView
    
    private let rootView = SuccessView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.handleDocuments = {
            let view = DocumentsView()
            var attributes = EKAttributes.partialScreen
            attributes.positionConstraints.size = .init(width: .offset(value: 0), height: .constant(value: Constants.screenHeight * 0.30))
            SwiftEntryKit.display(entry: view, using: attributes)
        }
    }
}
