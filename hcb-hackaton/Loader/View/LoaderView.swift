//
//  LoaderView.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit
import MBProgressHUD

final class LoaderView: UIView {
    
    override func layoutSubviews() {
        backgroundColor = .white
        let mb = MBProgressHUD.showAdded(to: self, animated: true)
        mb.progress = 0.5
        mb.animationType = .zoom
        mb.contentColor = .red
        mb.backgroundView.blurEffectStyle = .dark
        mb.label.text = "Пожалуйста, подождите..."
        mb.label.font = .medium17
        mb.label.textColor = .black
        mb.detailsLabel.text = "Мы принимаем решение"
        mb.detailsLabel.font = .regular14
        mb.detailsLabel.textColor = .gray
        mb.bezelView.color = .white
        mb.bezelView.blurEffectStyle = .extraLight
        mb.bezelView.style = .solidColor
    }
}
