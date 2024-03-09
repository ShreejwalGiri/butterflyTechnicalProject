//
//  StringExt.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import UIKit

extension String {
    public func fetchImageFromBaseConfigurations() -> UIImage {
        return UIImage(named: self, in: Bundle(for: ImageConfig.self), compatibleWith: nil) ?? UIImage()
    }
}
