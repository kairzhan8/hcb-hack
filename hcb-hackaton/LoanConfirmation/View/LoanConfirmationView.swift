//
//  LoanConfirmationView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import SnapKit

final class LoanConfirmationView: UIView {
    private let scrollView = UIScrollView()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, infoView, documentsButton, confirmButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Информация по кредиту"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .medium20
        return label
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor(red: 0.969, green: 0.153, blue: 0.102, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 15
        view.layer.shadowOffset = .init(width: 0, height: 4)
        return view
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStack, categoryStack, merchantStack, loanSumStack, monthlyPayStack, monthCountPayStack])
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименование товара"
        label.font = .regular14
        label.textColor = .gray
        return label
    }()
    
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "iPhone 12 mini"
        label.font = .regular14
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTitleLabel, nameValueLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = .regular14
        label.textColor = .gray
        return label
    }()
    
    private let categoryValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Смартфоны"
        label.font = .regular14
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var categoryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categoryTitleLabel, categoryValueLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let merchantTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Продавец"
        label.font = .regular14
        label.textColor = .gray
        return label
    }()
    
    private let merchantValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Sulpak"
        label.font = .regular14
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var merchantStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [merchantTitleLabel, merchantValueLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let loanSumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Одобренная сумма"
        label.font = .regular14
        label.textColor = .gray
        return label
    }()
    
    private let loanSumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "399 999 ₸"
        label.font = .regular14
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var loanSumStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loanSumTitleLabel, loanSumValueLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let monthlyPayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежемесячный платеж"
        label.font = .regular14
        label.textColor = .gray
        return label
    }()
    
    private let monthlyPayValueLabel: UILabel = {
        let label = UILabel()
        label.text = "66 666,5 ₸"
        label.font = .regular14
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var monthlyPayStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [monthlyPayTitleLabel, monthlyPayValueLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let monthCountPayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кол-во месяцев погашения"
        label.font = .regular14
        label.textColor = .gray
        return label
    }()
    
    private let monthCountPayValueLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.font = .regular14
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var monthCountPayStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [monthCountPayTitleLabel, monthCountPayValueLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
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
    
    let confirmButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Подтверждение (какой то текст)", for: .normal)
        btn.setImage(UIImage(named: Images.checkbox), for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.borderColor = Colors.gray.cgColor
        btn.layer.borderWidth = 1
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Colors.red
        btn.setTitle("Подтвердить", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

private extension LoanConfirmationView {
    func setup() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.size.equalToSuperview()
        }
        scrollView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self).inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        infoView.addSubview(infoStackView)
        addSubview(nextButton)
        makeConstraints()
    }
    
    func makeConstraints() {
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        infoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        documentsButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(56)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
}
