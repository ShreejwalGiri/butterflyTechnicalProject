//
//  AddItemVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 10/03/2024.
//

import Foundation
import LBTATools
import CoreData

class AddItemVc: RootVc {
    
    final let purchaseListVm = AppFactory.initialize().provideVmFactory().providePurchaseListVm()
    
    private lazy var productName: UITextField = {
        let textField = UITextField()
        textField.withHeight(30)
        textField.placeholder = "Enter Customer Name"
        return textField
    }()
    
    private lazy var quantity: UITextField = {
        let textField = UITextField()
        textField.withHeight(30)
        textField.placeholder = "Enter Quantity"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var price: UITextField = {
        let textField = UITextField()
        textField.withHeight(30)
        textField.placeholder = "Enter Price"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy private var saveItem: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save Purchase", for: .normal)
        btn.backgroundColor = .systemIndigo
        btn.addTarget(self, action: #selector(saveItemBtn), for: .touchUpInside)
        return btn
    }()
    
    
    open override func setupViews() {
        
        self.view.backgroundColor = .systemBackground
        
        let mainStack = UIView().stack(
            productName,
            quantity,
            price,
            UIView(),
            saveItem,
            spacing: 20
        ).padLeft(16).padRight(16).padTop(16).padBottom(20)
        
        self.view.addSubview(mainStack)
        mainStack.fillSuperview()
    }
    
    @objc
    func saveItemBtn() {
        purchaseListVm.delegate = self
        var item = Items()
        item.product = productName.text
        item.quantity = quantity.text
        item.price = price.text
        purchaseListVm.saveItem(data: item)
        self.dismiss(animated: true)
    }
}

extension AddItemVc: PurchaseDelegate {
    func getPurchaseList(data: [PurchaseModel]) {
    }
    
    func fetchSavedItem(data: [Items]) {
    }
    
    func purchaseFailure(msg: String) {
    }
}
