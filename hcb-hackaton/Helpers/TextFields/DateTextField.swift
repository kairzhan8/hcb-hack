//
//  DateTextField.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

class DateTextField: UITextField {
    
    private let imageView = UIImageView()
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    func configure() {
        setup()
    }
}

// MARK: -
private extension DateTextField {
    func setup() {
        textFieldAppearanceConfigure()
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        imageView.image = UIImage(named: Images.datePicker)
    }
    
    func textFieldAppearanceConfigure() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.addPadding(padding: .left(16))
        self.backgroundColor = .white
        self.layer.borderColor = Colors.gray.cgColor
        self.font = .regular14
        self.textColor = .black
    }
}
