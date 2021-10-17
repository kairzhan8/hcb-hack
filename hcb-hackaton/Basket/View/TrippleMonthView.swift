//
//  TrippleMonthView.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

class TrippleMonthView: UIView {
    
    let month3view: BasketMonthView = {
        let view = BasketMonthView()
        view.label.text = "3 мес"
        return view
    }()
    
    let month6view: BasketMonthView = {
        let view = BasketMonthView()
        view.label.text = "6 мес"
        return view
    }()
    
    let month12view: BasketMonthView = {
        let view = BasketMonthView()
        view.label.text = "12 мес"
        return view
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = hexColor(hex: "#D0D6D8")
        return view
    }()
    
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 5
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .equalCentering
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        addSubview(dividerView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.left.bottom.equalToSuperview()
            
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        stackView.addArrangedSubview(month3view)
        stackView.addArrangedSubview(month6view)
        stackView.addArrangedSubview(month12view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
