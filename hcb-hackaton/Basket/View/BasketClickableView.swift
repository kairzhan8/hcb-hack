//
//  BasketClickableView.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

class BasketClickableView: UIView {
    
    enum State {
        case active
        case disabled
    }
    
    var state: State = .disabled {
        didSet {
            imageView.image = state == .disabled ? #imageLiteral(resourceName: "Radio_Button_empty") : #imageLiteral(resourceName: "radio_button")
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "radio_button")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата полностью"
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = hexColor(hex: "#D0D6D8")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        [imageView, textLabel,dividerView].forEach { item in
            addSubview(item)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(20)
        }
        
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(6)
            make.right.equalToSuperview().inset(16)
        }
    }
}
