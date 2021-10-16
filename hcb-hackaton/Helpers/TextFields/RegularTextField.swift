//
//  RegularTextField.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

class RegularTextField: UITextField {
    
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
private extension RegularTextField {
    func setup() {
        textFieldAppearanceConfigure()
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
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
}

// MARK: - Paddings
extension UITextField {
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = equalPaddingView
            self.leftViewMode = .always
            // right
            self.rightView = equalPaddingView
            self.rightViewMode = .always
        }
    }
}
