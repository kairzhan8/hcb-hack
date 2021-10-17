//
//  StoriesPage.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 16.10.2021.
//

import UIKit

private let images = [#imageLiteral(resourceName: "stories6"), #imageLiteral(resourceName: "stories8"), #imageLiteral(resourceName: "stories5"), #imageLiteral(resourceName: "stories7")]

import UIKit
import SafariServices

final class DStoriesViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var closeView: (() -> Void)?
    
    // MARK: - Private Properties
    
    private var pb: DStoriesProgressBar!

    private var startIndex: Int = 0
    private var currentIndex: Int = 0
    private var touchInDate: Date = .init()

    private let defaults = UserDefaults.standard
    private let storiesTransitioningDelegate: StoriesTransitioningDelegate = .init()
    private var interactor: Interactor!
    private var didPan: Bool = false
    private var touchDownStartTime: Date!
    
    // MARK: - UI Elements
    
    private let bottomTapView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let textLabel: UILabel = {
        let l = UILabel()
        l.font = .medium20
        l.numberOfLines = 0
        l.textColor = .white
        return l
    }()
    
    private let dismissButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .black
        b.imageView?.contentMode = .scaleAspectFit
        b.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        b.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return b
    }()
    
    private let storiesMoreView: DStoriesMoreView = {
        let view = DStoriesMoreView()
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Initializers
    
    init(startIndex: Int = 0, cellFrame: CGRect) {
        self.startIndex = startIndex
        super.init(nibName: nil, bundle: nil)
        
        pb = DStoriesProgressBar(numberOfSegments: images.count, duration: 5)
        pb.frame = CGRect(x: 0, y: 0, width: view.frame.width - 72, height: 4)
        pb.delegate = self
        
        modalPresentationStyle = .overCurrentContext
        storiesTransitioningDelegate.originFrame = cellFrame
        transitioningDelegate = storiesTransitioningDelegate
        self.interactor = storiesTransitioningDelegate.interactor
        
        self.currentIndex = startIndex
        self.updateImage(index: startIndex)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGradient()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.pb.startAnimation(startIndex: self.startIndex)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.addSubview(imageView)
        view.addSubview(pb)
        view.addSubview(storiesMoreView)
        view.addSubview(dismissButton)
        view.addSubview(textLabel)
        
        let touchDown = UILongPressGestureRecognizer(target: self, action: #selector(didTouchDown))
        touchDown.minimumPressDuration = 0
        imageView.addGestureRecognizer(touchDown)
        
        let panG = UIPanGestureRecognizer(target: self, action: #selector(didDrag))
        panG.delegate = self
        imageView.addGestureRecognizer(panG)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        storiesMoreView.addSubview(bottomTapView)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(openBannerLink))
        swipeUp.direction = .up
        
        let tapUrlGesture = UITapGestureRecognizer(target: self, action: #selector(openBannerLink))
        self.bottomTapView.addGestureRecognizer(tapUrlGesture)
        self.storiesMoreView.addGestureRecognizer(swipeUp)
        self.storiesMoreView.addGestureRecognizer(tapUrlGesture)
        
        storiesMoreView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        
        bottomTapView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height + 4)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(32)
        }
        
        pb.snp.makeConstraints { (make) in
            make.centerY.equalTo(dismissButton)
            make.right.equalTo(dismissButton.snp.left).offset(-16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(4)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dismissButton.snp.bottom).offset(48)
            make.left.equalTo(32)
            make.right.equalTo(-32)
        }
    }
    
    // MARK: - Private functions
    
    @objc private func didDrag(_ sender: UIPanGestureRecognizer) {
        let percentThreshold: CGFloat = 0.1
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / imageView.bounds.height
        
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let downProgress = CGFloat(downwardMovementPercent)
        
        let upwardMovement = fminf(Float(verticalMovement), 0.0)
        let upwardMovementPercent = fminf(upwardMovement, 1.0)
        let upProgress = CGFloat(upwardMovementPercent)
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismissView()
        case .changed:
            didPan = true
            interactor.shouldFinish = downProgress > percentThreshold
            interactor.update(downProgress)
//            if upProgress < -0.1, let url = images[currentIndex].url, url != "", bannerList[currentIndex].target == .external {
//                openBannerLink()
//            }
        case .cancelled:
            interactor.cancelWithAnimation()
            interactor.hasStarted = false
        case .ended:
            interactor.shouldFinish ? interactor.finish() : interactor.cancelWithAnimation()
            interactor.hasStarted = false
        default:
            break
        }
    }
    
    @objc private func didTouchDown(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            didPan = false
            touchDownStartTime = Date()
            pb.isPaused = true
        } else if sender.state == .changed {
            
        } else if sender.state == .ended {
            let interval = Date().timeIntervalSince(touchDownStartTime)
            if interval < 0.15 && didPan == false {
                let touchX = sender.location(in: imageView).x
                touchX > imageView.frame.midX ? pb.skip() : pb.rewind()
            } else {
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
                    self?.pb.isPaused = false
                }
            }
        }
    }
    
    private func setupGradient() {
        let topGradientLayer = CAGradientLayer()
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 2)
        topGradientLayer.frame = self.view.bounds
        topGradientLayer.colors = [UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        self.imageView.layer.insertSublayer(topGradientLayer, at: 0)
        
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.frame = CGRect(x: 0, y: self.view.bounds.height / 2, width: self.view.bounds.width, height: self.view.bounds.height / 2)
        bottomGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.3).cgColor]
        self.imageView.layer.insertSublayer(bottomGradientLayer, at: 0)
    }
    
    private func updateImage(index: Int) {
        imageView.image = images[index]
    }
    
    @objc private func openBannerLink() {
//        guard let urlToWeb = bannerList[self.currentIndex].url else { return }
        pb.stopFromVC()
        
    }

    
    @objc private func dismissView() {
        dismiss(animated: true, completion: {
            self.closeView?()
        })
    }
}

extension DStoriesViewController: SegmentedProgressBarDelegate {
    func segmentedProgressBarChangedIndex(index: Int) {
        self.currentIndex = index
        updateImage(index: index)
    }
    
    func segmentedProgressBarFinished() {
        dismissView()
    }
}

extension DStoriesViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

final class DStoriesMoreView: UIView {
    
    // MARK: - UI Elements
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "checkbox")
        return iv
    }()
    
    private let moreLabel: UILabel = {
        let l = UILabel()
        l.font = .medium14
        l.textColor = .white
        l.text = "Узнать подробнее"
        l.textAlignment = .center
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(iconImage)
        addSubview(moreLabel)
        moreLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-56)
        }
        iconImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(moreLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(20)
        }
    }
}
