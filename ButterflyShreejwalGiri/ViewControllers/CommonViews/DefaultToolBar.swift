//
//  DefaultToolBar.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import UIKit
import LBTATools

open class DefaultToolBar: UIView {
    
    let titleConstants = "Test"
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(ImageConfig.icons.left_arrow_circle_fill, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.withSize(CGSize(width: 35, height: 35))
        return btn
    }()

    lazy var toolBarTitle: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    public init(toolbarTitle: String) {
        super.init(frame: CGRect.zero)
        self.toolBarTitle.text = toolbarTitle
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.addSubview(containerView)
        containerView.fillSuperview()
        
        let buttonStack = UIView().hstack(
            backButton,
            alignment: .center,
            distribution: .fillProportionally
        )
        
        let backBtnAndTitleHStack = UIView().hstack(
            buttonStack,
            toolBarTitle,
            spacing: 12
        )
        
        let mainStack = UIView().stack(
            backBtnAndTitleHStack
        )
        
        containerView.addSubview(mainStack)
        mainStack.fillSuperview()
    }
}
