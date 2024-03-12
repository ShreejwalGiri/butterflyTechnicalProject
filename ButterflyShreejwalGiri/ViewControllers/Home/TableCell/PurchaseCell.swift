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
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    lazy private var productId: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var numberOfItems: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    func configure(with item: Items) {
        
        self.contentView.backgroundColor = .systemBackground
        
        self.product.text = item.product
        
        self.productId.text = "Product ID : \( item.id ?? ""  )"
        self.numberOfItems.text = "No. of Items : \( item.quantity ?? ""  )"
        
        let itemInfo = UIView().stack(
            productId,
            numberOfItems,
            spacing: 0
        )
        
        stack(
            product,
            UIView(),
            itemInfo,
            spacing: 10.0,
            alignment: .leading
        ).padLeft(20).padRight(20).padTop(10).padBottom(5)
    }

}
