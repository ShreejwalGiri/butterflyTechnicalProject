//
//  ColorConfig.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import UIKit


open class ColorConfig {
    public static var primaryColor: UIColor             = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    public static var secondaryColor: UIColor           = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9607843137, alpha: 1)
    public static var backgroundColor: UIColor          = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9607843137, alpha: 1)
    
    public static var baseConfig                        = BaseConfig.self
}

public struct BaseConfig {
    public static var defaultGrey: UIColor               = #colorLiteral(red: 0.7764705882, green: 0.7921568627, blue: 0.8156862745, alpha: 1)
    public static var defaultWhite: UIColor              = .systemBlue
    public static var defaultBlack: UIColor              = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public static func primaryFade(alphaComponent: CGFloat = 0.3) -> UIColor {
        return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).withAlphaComponent(alphaComponent)
    }
}
