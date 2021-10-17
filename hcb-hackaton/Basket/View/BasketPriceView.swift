//
//  BasketPriceView.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

class BasketPriceView: UIView {
    
    lazy var loanPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = hexColor(hex: "#02B926")
        view.layer.cornerRadius = 12
        return view
    }()
    
    let loanPricelabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "66 666,5 ₸"
        label.font = Fonts.medium(size: 14)
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.secondaryGray
        label.text = "x 6 мес"
        label.font = .medium12
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainBlack
        label.text = "399 999 ₸"
        label.font = .medium20
        label.textAlignment = .right
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = hexColor(hex: "#D0D6D8")
        return view
    }()
    
    let topDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = hexColor(hex: "#D0D6D8")
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = hexColor(hex: "#FEE9E8")
        button.setTitleColor(Colors.red, for: .normal)
        button.setTitle("Добавить еще", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = Fonts.medium(size: 14)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Далее", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = Fonts.medium(size: 14)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let topView = UIView()
        addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        [loanPriceView, monthLabel, dividerView, priceLabel, topDividerView].forEach { item in
            topView.addSubview(item)
        }
        
        topDividerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        let bottomView = UIView()
        addSubview(bottomView)
        [addButton, nextButton].forEach { item in
            bottomView.addSubview(item)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(48)
        }
        
        loanPriceView.addSubview(loanPricelabel)
        
        loanPriceView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        loanPricelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.left.equalTo(loanPriceView.snp.right).offset(4)
            make.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(self.snp.centerX).offset(-8)
            make.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(self.snp.centerX).offset(8)
            make.height.equalTo(44)
        }
    }
    
}
