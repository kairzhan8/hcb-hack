//
//  EKAttributes + Extension.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import SwiftEntryKit

struct Constants {
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
}
extension EKAttributes {
    
    /// Vertical offset value for EK-presented screens on medium-sized devices
    private static let mediumVerticalOffset: CGFloat = 70.0
    /// Vertical offset value for EK-presented screens on large-sized devices
    private static let largeVerticalOffset: CGFloat = 140.0
    
    enum ScreenFamily {
        case S
        case M
        case L
        
        static func whichFamily(height: CGFloat) -> ScreenFamily {
            if height < 600 {
                return .S
            }
            if height <= 667 {
                return .M
            }
            return .L
        }
    }
    
    static var partialScreen: EKAttributes {
        var attributes = EKAttributes.bottomFloat
        // Visuals
        attributes.entryBackground = .color(color: .white)
        attributes.screenBackground = .color(color: EKColor.black.with(alpha: 0.5))
        attributes.roundCorners = .top(radius: 10)
        attributes.statusBar = .dark
        
        // Interaction
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .forward
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.5, spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        
        // Dimensions
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: Constants.screenWidth),
            height: .intrinsic)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        
        let family = ScreenFamily.whichFamily(height: Constants.screenHeight)
        switch family {
        case .S:
            attributes.positionConstraints.size = .init(
                width: .offset(value: 0), height: .offset(value: 0))
        case .M:
            attributes.positionConstraints.size = .init(
                width: .offset(value: 0), height: .offset(value: mediumVerticalOffset))
        case .L:
            attributes.positionConstraints.size = .init(
                width: .offset(value: 0), height: .offset(value: largeVerticalOffset))
        }
        return attributes
    }
}
