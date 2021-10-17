//
//  SegmentedProgressBar.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 16.10.2021.
//

import Foundation
import UIKit

protocol SegmentedProgressBarDelegate: AnyObject {
    func segmentedProgressBarChangedIndex(index: Int)
    func segmentedProgressBarFinished()
}

final class DStoriesProgressBar: UIView {
    
    // MARK: - Private properties
    
    private var segments = [SegmentStory]()
    private let duration: TimeInterval
    private var hasDoneLayout: Bool = false
    private var currentAnimationIndex: Int = 0
    
    // MARK: - Public properties
    
    weak var delegate: SegmentedProgressBarDelegate?
    var padding: CGFloat = 2.0
    
    var topColor = UIColor.white {
        didSet {
            self.updateColors()
        }
    }
    
    var bottomColor = UIColor.white.withAlphaComponent(0.25) {
        didSet {
            self.updateColors()
        }
    }
    private var lastWidth: CGFloat = 0.0
    private var startTime = Date()
    
    class SegmentStory {
        let bottomSegmentView = UIView()
        let topSegmentView = UIView()
        init() { }
    }
    
    var isPaused: Bool = false {
        didSet {
            if isPaused {
                for segment in segments {
                    let layer = segment.topSegmentView.layer
                    let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
                    layer.speed = 0.0
                    layer.timeOffset = pausedTime
                    lastWidth = (CGFloat((Double(Date().timeIntervalSince(startTime))) / duration) * segment.bottomSegmentView.frame.width)
                }
            } else {
                let segment = segments[currentAnimationIndex]
                let layer = segment.topSegmentView.layer
                let pausedTime = layer.timeOffset
                layer.speed = 1.0
                layer.timeOffset = 0.0
                layer.beginTime = 0.0
                let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
                layer.beginTime = timeSincePause
            }
        }
    }
    
    // MARK: - Initializers
    
    init(numberOfSegments: Int, duration: TimeInterval = 5.0) {
        self.duration = duration
        super.init(frame: CGRect.zero)
        
        for _ in 0..<numberOfSegments {
            let segment = SegmentStory()
            addSubview(segment.bottomSegmentView)
            addSubview(segment.topSegmentView)
            segments.append(segment)
        }
        
        self.updateColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if hasDoneLayout {
            return
        }
        let width = (frame.width - (padding * CGFloat(segments.count - 1)) ) / CGFloat(segments.count)
        for (index, segment) in segments.enumerated() {
            let segFrame = CGRect(x: CGFloat(index) * (width + padding), y: 0, width: width, height: frame.height)
            segment.bottomSegmentView.frame = segFrame
            segment.topSegmentView.frame = segFrame
            segment.topSegmentView.frame.size.width = 0
            
            let cr = frame.height / 2
            segment.bottomSegmentView.layer.cornerRadius = cr
            segment.topSegmentView.layer.cornerRadius = cr
        }
        hasDoneLayout = true
    }
    
    // MARK: - Private functions
    
    private func animate(animationIndex: Int = 0) {
        startTime = Date()
        let nextSegment = segments[animationIndex]
        currentAnimationIndex = animationIndex
        self.isPaused = false
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            nextSegment.topSegmentView.frame.size.width = nextSegment.bottomSegmentView.frame.width
        }) { (finished) in
            if !finished { return }
            self.next()
        }
    }
    
    // MARK: - Public functions
    
    func startAnimation(startIndex: Int = 0) {
        layoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            for _ in 0 ..< startIndex {
                self.skip()
            }
        })
        animate()
    }
    
    func stopFromVC() {
        isPaused = true
        self.subviews.forEach({
            $0.layer.removeAllAnimations()
        })
        self.layer.removeAllAnimations()
        let segment = segments[currentAnimationIndex]
        segment.topSegmentView.removeFromSuperview()
        segment.topSegmentView.frame.size.width = lastWidth
        addSubview(segment.topSegmentView)
    }
    
    func continueFromVC() {
        let segment = segments[currentAnimationIndex]
        self.isPaused = false
        let fullWidth = segment.bottomSegmentView.frame.width
        startTime = Date()
        UIView.animate(withDuration: duration * Double(((fullWidth - lastWidth) / fullWidth)), delay: 0.0, options: .curveLinear, animations: {
            segment.topSegmentView.frame = CGRect(
                x: segment.topSegmentView.frame.minX,
                y: segment.topSegmentView.frame.minY,
                width: fullWidth,
                height: segment.topSegmentView.frame.height)
        }) { (finished) in
            if !finished { return }
            self.next()
        }
    }
    
    private func updateColors() {
        for segment in segments {
            segment.topSegmentView.backgroundColor = topColor
            segment.bottomSegmentView.backgroundColor = bottomColor
        }
    }
    
    private func next() {
        let newIndex = self.currentAnimationIndex + 1
        if newIndex < self.segments.count {
            self.animate(animationIndex: newIndex)
            self.delegate?.segmentedProgressBarChangedIndex(index: newIndex)
        } else {
            self.delegate?.segmentedProgressBarFinished()
        }
    }
    
    func skip() {
        let currentSegment = segments[currentAnimationIndex]
        currentSegment.topSegmentView.frame.size.width = currentSegment.bottomSegmentView.frame.width
        currentSegment.topSegmentView.layer.removeAllAnimations()
        self.next()
    }
    
    func rewind() {
        let currentSegment = segments[currentAnimationIndex]
        currentSegment.topSegmentView.layer.removeAllAnimations()
        currentSegment.topSegmentView.frame.size.width = 0
        let newIndex = max(currentAnimationIndex - 1, 0)
        let prevSegment = segments[newIndex]
        prevSegment.topSegmentView.frame.size.width = 0
        self.animate(animationIndex: newIndex)
        self.delegate?.segmentedProgressBarChangedIndex(index: newIndex)
    }
}
