//
//  BasketMonthView.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

class BasketMonthView: UIView {
    
    enum State {
        case selected
        case disabled
        case notSelected
    }
    
    var state: State = .notSelected {
        didSet {
            if state == .selected {
                label.textColor = Colors.red
                mainView.layer.borderColor = Colors.red.cgColor
            } else if state == .notSelected {
                mainView.layer.borderColor = Colors.secondaryGray.cgColor
                label.textColor = Colors.secondaryGray
            } else if state == .disabled {
                mainView.layer.borderColor = UIColor(red: 0.396, green: 0.408, blue: 0.482, alpha: 1).cgColor
                label.textColor = UIColor(red: 0.396, green: 0.408, blue: 0.482, alpha: 1)
            }
        }
    }
    
    let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.5
        
        view.layer.borderColor = UIColor(red: 1, green: 0.086, blue: 0.208, alpha: 1).cgColor
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = Colors.secondaryGray
        label.text = "6 мес"
        label.font = Fonts.medium(size: 10)
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
        mainView.layer.borderColor = Colors.secondaryGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(12)
        }
    }
}
