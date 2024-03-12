//
//  LabelTheme.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import UIKit

class LabelThemes {
    public static var baseTheme = BaseTheme.self
}

class BaseTheme {
    static func systemBold_14() -> UILabel {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 12)
        return lbl
    }
    
    static func systemRegular_12() -> UILabel {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }
    
    static func systemSmallItalic_10() -> UILabel {
        let lbl = UILabel()
        lbl.font = .italicSystemFont(ofSize: 10)
        return lbl
    }

}
