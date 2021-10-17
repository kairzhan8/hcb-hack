//
//  QRScanPage.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 16.10.2021.
//

import AVFoundation
import UIKit

final class QRScanPage: UIViewController {
    
    // MARK: - Types
    
    struct Constants {
        static let scanViewHeight: CGFloat = 0.65 * UIScreen.main.bounds.width
    }
    
    // MARK: - UI elements
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let maskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    private let qrView: UIView = UIView()
    
    private let backButton: UIButton = {
        let button = UIButton()
//        button.setImage(HBAssets.icBackWhite.image, for: .normal)
//        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = HBFonts.Manrope.semiBold.font(size: 16)
//        label.textColor = HBColors.Text.contrast.color
//        label.text = HBStrings.Payments.scanningQr
        label.textColor = .black
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Наведите камеру на ценник"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private lazy var storiesView: StoriesView = {
        let view = StoriesView()
//        view.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        view.delegate = self
        return view
    }()
    
    // MARK: - Private properties
    
    
    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setQR()
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = UIColor.black
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func makeUI() {
        view.backgroundColor = UIColor.black
        title = "Покупка товара"
        setupQRView()
        setNavBar()
        setupInfoLabel()
    }
}

extension QRScanPage: StoriesViewDelegate {
    func didSelectedStories(cell: UICollectionViewCell, index: Int) {
        let cellFrame: CGRect
        if let frame = cell.globalFrame {
            cellFrame = frame
        } else {
            cellFrame = CGRect(x: cell.frame.minX,
                               y: cell.frame.minY + cell.frame.width,
                               width: cell.frame.width,
                               height: cell.frame.height)
        }
        
        let storiesVC = DStoriesViewController(startIndex: index, cellFrame: cellFrame)
        self.navigationController?.present(storiesVC, animated: true)
    }
    
    func didSelectedStories() {
        
    }
}

private extension QRScanPage {
    
    func setQR() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            dismiss(animated: true)
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            dismiss(animated: true)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(previewLayer, at: 0)
        captureSession.startRunning()
    }

    func setupQRView() {
        view.addSubview(maskView)
        maskView.frame = view.layer.bounds
        maskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(qrView)
        qrView.snp.makeConstraints {
            $0.height.equalTo(Constants.scanViewHeight)
            $0.width.equalTo(Constants.scanViewHeight)
            $0.center.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapQR))
        qrView.addGestureRecognizer(tapGesture)
        qrView.layer.addSublayer(self.createFrame())
        setupMaskClearFrame()
    }
    
    @objc func tapQR() {
        let basketVC = BasketPage()
        self.navigationController?.pushViewController(basketVC, animated: true)
    }
    
    func setNavBar() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        
        view.addSubview(storiesView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height + 16)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(24)
        }
        
        storiesView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(qrView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    func createFrame() -> CAShapeLayer {
        let height: CGFloat = Constants.scanViewHeight
        let width: CGFloat = Constants.scanViewHeight
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 1, y: 50))
        path.addLine(to: CGPoint(x: 1, y: 1))
        path.addLine(to: CGPoint(x: 50, y: 1))
        path.move(to: CGPoint(x: height - 51, y: 1))
        path.addLine(to: CGPoint(x: height - 1, y: 1))
        path.addLine(to: CGPoint(x: height - 1, y: 51))
        path.move(to: CGPoint(x: 1, y: width - 51))
        path.addLine(to: CGPoint(x: 1, y: width - 1))
        path.addLine(to: CGPoint(x: 51, y: width - 1))
        path.move(to: CGPoint(x: width - 51, y: height - 1))
        path.addLine(to: CGPoint(x: width - 1, y: height - 1))
        path.addLine(to: CGPoint(x: width - 1, y: height - 51))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = Colors.red.cgColor
        shape.lineWidth = 6
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }
    
    func setupMaskClearFrame() {
        let maskLayer = CALayer()
        maskLayer.frame = view.bounds
        let squareLayer = CAShapeLayer()
        squareLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        let finalPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height),
            cornerRadius: 0)
        let squareX = view.bounds.width / 2 - Constants.scanViewHeight / 2
        let squareY = view.bounds.height / 2 - Constants.scanViewHeight / 2
        let squareRect: CGRect = .init(x: squareX,
                                       y: squareY,
                                       width: Constants.scanViewHeight,
                                       height: Constants.scanViewHeight)
        let squarePath = UIBezierPath(roundedRect: squareRect, cornerRadius: 0)
        finalPath.append(squarePath.reversing())
        squareLayer.path = finalPath.cgPath
        squareLayer.borderColor = UIColor.white.withAlphaComponent(1).cgColor
        maskLayer.addSublayer(squareLayer)
        maskView.layer.mask = maskLayer
    }
}

extension QRScanPage: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                let outputValue = readableObject.stringValue
                else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            scannedOutput(outputValue)
        }
        
        dismiss(animated: true)
    }
}
