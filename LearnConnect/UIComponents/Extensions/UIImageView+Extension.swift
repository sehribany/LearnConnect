//
//  UIImageView+Extension.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 23.11.2024.
//

import UIKit
import Kingfisher

// MARK: - Set Image with Placeholder and Resizing
extension UIImageView {
    static let fadeAnimation = KingfisherOptionsInfoItem.transition(.fade(0.2))
    
    func setImage(_ string: String?, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        let url               = URL(string: string ?? "")
        let width             = UIScreen.main.bounds.width
        let processor         = ResizingImageProcessor(referenceSize: CGSize(width: width, height: width), mode: .aspectFit)
        self.kf.setImage(with: url, placeholder: placeholder, options: [UIImageView.fadeAnimation, .processor(processor)])
    }
    
    func setImageScaled(_ string: String?, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        let url               = URL(string: string ?? "")
        let processor         = ResizingImageProcessor(referenceSize: CGSize(width: 150, height: 150), mode: .aspectFit)
        self.kf.setImage(with: url, placeholder: placeholder, options: [UIImageView.fadeAnimation, .processor(processor)])
    }
}

