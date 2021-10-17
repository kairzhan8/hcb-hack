//
//  FaceCheckPage.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

class FaceCheckPage: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "iOS - QR P2P - Scaner")
        image.contentMode = .scaleToFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
