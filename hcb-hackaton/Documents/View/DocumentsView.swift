//
//  DocumentsView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import SnapKit


final class DocumentsView: UIView {
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, dividerLine, firstButton, secondButton, thirdButton, forthButton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Документы"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .medium20
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray
        return view
    }()
    
    let firstButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("График погашения кредита", for: .normal)
        btn.setImage(UIImage(named: Images.doc), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .regular14
        return btn
    }()
    
    let secondButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Общие условия кредитного договора", for: .normal)
        btn.setImage(UIImage(named: Images.doc), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .regular14
        return btn
    }()
    
    let thirdButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Кредитный договор", for: .normal)
        btn.setImage(UIImage(named: Images.doc), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .regular14
        return btn
    }()
    
    let forthButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Правила страхования", for: .normal)
        btn.setImage(UIImage(named: Images.doc), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        btn.titleEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .regular14
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
}

private extension DocumentsView {
    func setup() {
        backgroundColor = .white
        layer.cornerRadius = 12
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview()
        }
        dividerLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
}
