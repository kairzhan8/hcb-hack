//
//  StoriesCell.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 16.10.2021.
//

import UIKit

class StoriesCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesCell {
    func setup() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(110)
            make.width.equalTo(130)
        }
    }
}
