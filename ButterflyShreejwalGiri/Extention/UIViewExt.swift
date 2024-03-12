//
//  UIViewExt.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import UIKit

extension UIView {
    
    public func addRoundedCorners(cornerRadius: CGFloat = 0.0) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius == 0.0 ? self.frame.size.height / 2 : cornerRadius
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskPath.cgPath
        borderLayer.lineWidth = borderWidth
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(borderLayer)
    }
    
    public func addShadow(shadowRadius: CGFloat, offsetX: CGFloat, offsetY: CGFloat, color: UIColor, opacity: Float) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    public func addBlurEffect(style: UIBlurEffect.Style, alpha: CGFloat = 1.0) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = alpha
        addSubview(blurView)
    }
}
