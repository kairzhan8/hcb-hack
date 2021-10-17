//
//  Fonts.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

public extension UIFont {
    static let medium20 = UIFont(name: "HelveticaNeue-Medium", size: 20)
    static let regular14 = UIFont(name: "HelveticaNeue", size: 14)
    static let regular18 = UIFont(name: "HelveticaNeue", size: 18)
    static let regular11 = UIFont(name: "HelveticaNeue", size: 11)
    static let medium14 = UIFont(name: "HelveticaNeue-Medium", size: 14)
    static let medium12 = UIFont(name: "HelveticaNeue-Medium", size: 12)
    static let medium17 = UIFont(name: "HelveticaNeue-Medium", size: 17)
    static let medium32 = UIFont(name: "HelveticaNeue-Medium", size: 32)
}

public class Fonts {
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
}
