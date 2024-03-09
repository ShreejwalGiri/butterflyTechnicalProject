//
//  TitleOnlyHeaderCell.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import UIKit

open class TitleOnlyHeaderCell: UITableViewHeaderFooterView {
    
    lazy var titleLabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.contentView.backgroundColor = .clear
        
        let mainHStack = UIView().hstack(
            titleLabel
        )
        
        self.contentView.addSubview(mainHStack)
        mainHStack.fillSuperview(padding: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
}
