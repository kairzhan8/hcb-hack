//
//  AlertView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import SnapKit

final class AlertView: UIView {
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кредит не одобрен"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .medium17
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Просим выбрать другой способ оплаты, и подать заявку заново"
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .regular14
        return label
    }()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = .medium14
        btn.setTitle("Закрыть", for: .normal)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func configure(data: AlertModel) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        button.setTitle(data.buttonTitle, for: .normal)
    }
}

private extension AlertView {
    func setup() {
        [imageView, titleLabel, subtitleLabel, button].forEach { addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.left.right.equalToSuperview().inset(32)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(14)
            $0.left.right.equalToSuperview().inset(58)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(44)
        }
    }
}
