//
//  LoanConfirmationPage.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import SafariServices
import SwiftEntryKit

final class LoanConfirmationPage: UIViewController {
    
    typealias RootView = LoanConfirmationView
    
    private let rootView = LoanConfirmationView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.handleCondition = { [weak self] in
            self?.presentSafariVC(with: (URL(string: "https://web.stanford.edu/class/archive/cs/cs161/cs161.1168/lecture4.pdf"))!)
        }
        rootView.handleDocuments = {
            let view = DocumentsView()
            var attributes = EKAttributes.partialScreen
            attributes.positionConstraints.size = .init(width: .offset(value: 0), height: .constant(value: Constants.screenHeight * 0.30))
            SwiftEntryKit.display(entry: view, using: attributes)
        }
        
        rootView.nextButton.addTarget(self, action: #selector(nextTouched), for: .touchUpInside)
    }
    
    @objc func nextTouched() {
        let faceCheckPage = FaceCheckPage()
        let tap = UITapGestureRecognizer(target: self, action: #selector(faceTouched))
        faceCheckPage.view.addGestureRecognizer(tap)
        self.navigationController?.pushViewController(faceCheckPage, animated: true)
    }
    
    @objc func faceTouched() {
        let vc = QRPage()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    
}
