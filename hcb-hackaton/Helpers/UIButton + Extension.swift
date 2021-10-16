//
//  UIButton + Extension.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

extension UIButton {

    static func customSystemButton(title: String, subtitle: String) -> UIButton {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.byWordWrapping

        let titleAttributes = [
            NSAttributedString.Key.font : UIFont.regular14,
            NSAttributedString.Key.paragraphStyle : style,
            NSAttributedString.Key.foregroundColor : UIColor.gray
        ]
        let subtitleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : UIFont.regular14,
            NSAttributedString.Key.paragraphStyle : style,
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]

        let attributedString = NSMutableAttributedString(string: title, attributes: titleAttributes)
        attributedString.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))

        let button = UIButton(type: UIButton.ButtonType.system)
        button.setAttributedTitle(attributedString, for: UIControl.State.normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        return button
    }

    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
