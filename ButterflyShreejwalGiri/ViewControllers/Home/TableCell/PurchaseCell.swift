//
//  PurchaseCell.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import LBTATools

class PurchaseCell: UITableViewCell {
    
    lazy private var product: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy private var quantity: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy private var price: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: Items) {
        
        self.product.text = item.product
        
        hstack(
            product,
            UIView(),
            spacing: 10.0,
            alignment: .center
        ).padLeft(10).padRight(10).padTop(5).padBottom(5)
    }

}
