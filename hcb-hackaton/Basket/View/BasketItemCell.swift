//
//  BasketItemCell.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

struct BasketItemCellModel {
    let image: UIImage
    let title: String
    let subTitle: String
    let price: String
}

final class BasketItemCell: UITableViewCell {
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 0.816, green: 0.839, blue: 0.847, alpha: 1).cgColor
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium14
        label.textColor = Colors.mainBlack
        label.text = "iPhone 12 mini, 256 gb"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium12
        label.textColor = Colors.secondaryGray
        label.text = "Смартфоны"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .medium20
        label.text = "399 999,00 ₸"
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = Colors.red
        label.font = Fonts.medium(size: 18)
        return label
    }()
    
    private let trashButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "trash"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.shadowColor = UIColor(red: 0.969, green: 0.153, blue: 0.102, alpha: 0.1).cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowRadius = 15
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.cornerRadius = 6
    }
    
    func configure(model: BasketItemCellModel) {
        iconView.image = model.image
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        priceLabel.text = model.price
    }
}


private extension BasketItemCell {
    func setup() {
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        [iconView, titleLabel, subTitleLabel, priceLabel, countLabel, trashButton].forEach { item in
            mainView.addSubview(item)
        }
        
        trashButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(12)
            make.size.equalTo(32)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
            make.size.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(iconView.snp.right).offset(16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalTo(iconView.snp.right).offset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.right.bottom.equalToSuperview().inset(12)
        }
    }
}
