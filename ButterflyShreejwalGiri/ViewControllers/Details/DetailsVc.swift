//
//  DetailsVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 10/03/2024.
//

import Foundation
import UIKit

class DetailsVc: RootVc {
    
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
    
    lazy private var invoiceNumber: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var receivedStatus: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func popupateData(_ item: Items) {
        self.title = item.product
        self.product.text = "Item Name: \(item.product ?? "")"
        self.productId.text = "Product ID: \(item.id ?? "")"
        self.numberOfItems.text = "Quantity: \(item.quantity ?? "")"
        self.receivedStatus.text = "Recdived Status: \( "N/A")"
        self.invoiceNumber.text = "Invoice Number: \( "N/A")"
    }
    
    internal override func setupViews() {
        super.setupViews()
        
        let mainView = UIView().stack(
            product,
            UIView().stack(
                productId,
                numberOfItems,
                invoiceNumber,
                receivedStatus
            ),
            UIView(),
            spacing: 12
        ).padLeft(16).padRight(16).padTop(20)
        
        self.view.addSubview(mainView)
        mainView.fillSuperviewSafeAreaLayoutGuide()
    }
    
    
    
}
