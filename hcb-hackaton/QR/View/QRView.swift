//
//  QRView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit
import SnapKit

final class QRView: UIView {
    
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Важно!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .medium32
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявка предварительно одобрена. Чтобы закончить процесс покупки товара в кредит, попросите менеджера магазина отсканировать QR код ниже"
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .regular18
        return label
    }()
    
    private let qrImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

private extension QRView {
    func setup() {
        backgroundColor = .white
        [imageView, titleLabel, subtitleLabel, qrImage].forEach { addSubview($0) }
        makeConstraints()
        imageView.image = UIImage(named: Images.warning)
        qrImage.image = UIImage(named: Images.qr)
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(27)
        }
        
        qrImage.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(40)
            $0.size.equalTo(295)
        }
    }
}
