//
//  SuccessView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 17.10.2021.
//

import UIKit
import SnapKit

final class SuccessView: UIView {
    
    var handleDocuments: (() -> Void)?
    
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вам одобрен кредит на товар"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .medium20
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наслаждайтесь покупкой!"
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .regular14
        return label
    }()
    
    private let infoImage = UIImageView()
    
    let documentsButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Смотреть документы", for: .normal)
        btn.setImage(UIImage(named: Images.documents), for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.borderColor = Colors.gray.cgColor
        btn.layer.borderWidth = 1
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let toMainButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("На главную", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .medium14
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    let scanButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors.pink
        btn.setTitle("Сканировать еще", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.titleLabel?.font = .medium14
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

private extension SuccessView {
    func setup() {
        backgroundColor = .white
        [imageView, titleLabel, subtitleLabel, infoImage, documentsButton].forEach { addSubview($0) }
        addSubview(toMainButton)
        addSubview(scanButton)
        imageView.image = UIImage(named: Images.success)
        infoImage.image = UIImage(named: Images.info)
        makeConstraints()
        documentsButton.addTarget(self, action: #selector(handleDocument), for: .touchUpInside)
    }
    
    @objc func handleDocument() {
        handleDocuments?()
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(27)
        }
        
        infoImage.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
        }
        
        documentsButton.snp.makeConstraints {
            $0.top.equalTo(infoImage.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        scanButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(26)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        toMainButton.snp.makeConstraints {
            $0.bottom.equalTo(scanButton.snp.top).offset(-12)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
