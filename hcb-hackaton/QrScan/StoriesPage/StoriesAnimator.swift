//
//  StoriesAnimator.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import Foundation
import UIKit

// MARK: - Dismiss Animator
class StoriesDismissAnimator: NSObject {
    var originFrame = CGRect.zero
}

extension StoriesDismissAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }
        
        let containerView = transitionContext.containerView
        
        let finalFrame = originFrame
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        snapshot?.layer.masksToBounds = true
        
        containerView.addSubview(snapshot!)
        fromVC.view.isHidden = true
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 5 / 6, animations: {
                                        snapshot?.layer.cornerRadius = 4 //self.originFrame.width/2.0
                                        snapshot?.frame = finalFrame
                                        snapshot?.alpha = 0.0
                                    })
        }) { _ in
            fromVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

// MARK: - Present Animator
class StoriesPresentAnimator: NSObject {
    var originFrame = CGRect.zero
}

extension StoriesPresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = transitionContext.viewController(forKey: .to)
            else { return }
        
        let containerView = transitionContext.containerView
        
        let initialFrame = originFrame
        let finalFrame = UIScreen.main.bounds
        
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        snapshot?.layer.cornerRadius = 4 // originFrame.width/2.0
        snapshot?.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            animations: {
                snapshot?.frame = finalFrame
                snapshot?.layer.cornerRadius = 0.0
            }, completion: { _ in
                toVC.view.isHidden = false
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}

// MARK: - Transition delegate

class StoriesTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    var originFrame: CGRect = .zero
    let interactor = Interactor()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let s = StoriesPresentAnimator()
        s.originFrame = originFrame
        return s
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let s = StoriesDismissAnimator()
        s.originFrame = originFrame
        return s
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

class Interactor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
    
    private var start: CGFloat = 0
    private var timer: Timer?
    
    func cancelWithAnimation() {
        var start = percentComplete
        TimerShim.scheduledTimer(withTimeInterval: 0.005, repeats: true) { [weak self] (timer) in
            if start > 0.0 {
                start -= 0.01
                self?.update(fmax(start, 0.0))
            } else {
                self?.cancel()
                timer.invalidate()
            }
        }
    }
    
    class TimerShim {
        private var timer: Timer?
        private let block: (Timer) -> Void
        
        private init(timeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) {
            self.block = block
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: repeats)
        }
        
        @discardableResult class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
            return TimerShim(timeInterval: interval, repeats: repeats, block: block).timer!
        }
        
        @objc private func timerDidFire() {
            block(timer!)
        }
    }
}
