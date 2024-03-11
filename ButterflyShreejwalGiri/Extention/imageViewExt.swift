//
//  imageViewExt.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import UIKit
import SDWebImage

public extension UIImageView {
    func loadImage(fromWebPath webPath: String, placeholder: UIImage? = nil) {
        let url = URL(string: webPath)
        self.sd_setImage(with: url, placeholderImage: placeholder)
    }
    
    func setImageWithAnimation(image: UIImage?, duration: CGFloat = 0.3) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        })
    }
}
