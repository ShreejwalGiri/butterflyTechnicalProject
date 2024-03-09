//
//  ImageConfig.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import UIKit

open class ImageConfig {
    
    static func getImage(name: String) -> UIImage {
        return UIImage(named: name) ?? name.fetchImageFromBaseConfigurations()
    }
    
    static func getSystemImage(name: String) -> UIImage {
        return UIImage(systemName: name) ?? name.fetchImageFromBaseConfigurations()
    }
    
    public static var icons                             = Icons.self
}


public struct Icons {
    public static var left_arrow_circle_fill            = ImageConfig.getImage(name: "left_arrow_circle_fill")
}
