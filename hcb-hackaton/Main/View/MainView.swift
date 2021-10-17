//
//  MainView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    private let slider = UIImageView()
    
    private let buttons = UIImageView()
    
    let scanButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Покупки через сканнер", for: .normal)
        btn.setImage(UIImage(named: Images.scan), for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.borderColor = Colors.gray.cgColor
        btn.layer.borderWidth = 1
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

private extension MainView {
    func setup() {
        backgroundColor = .white
        [slider, buttons, scanButton].forEach { addSubview($0)}
        makeConstraints()
        slider.image = UIImage(named: Images.slider)
        buttons.image = UIImage(named: Images.buttons)
    }
    
    func makeConstraints() {
        slider.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        buttons.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        scanButton.snp.makeConstraints {
            $0.top.equalTo(buttons.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
