//
//  PurchaseVm.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public protocol PurchaseDelegate {
    func getPurchaseList(data: [PurchaseModel])
    func purchaseFailure(msg: String)
}

public class PurchaseVm: BaseVm {
    
    let purchaseUc: PurchaseUc
    public var delegate: PurchaseDelegate?
    
    public init(purchaseUc: PurchaseUc) {
        self.purchaseUc = purchaseUc
    }
    
    public func getPurchaseList() {
        self.loading.onNext(true)
        disposeBag.insert(
            
            purchaseUc.getPurchaseData().subscribe(onNext: { purchaseModel in
                self.loading.onNext(false)
                if purchaseModel.isEmpty == false {
                    self.delegate?.getPurchaseList(data: purchaseModel)
                } else {
                    self.delegate?.purchaseFailure(msg: self.errorMsg)
                }
                
            }, onError: { error in
                self.loading.onNext(false)
                self.delegate?.purchaseFailure(msg: self.errorMsg)
            })
        )
    }
    
    
}
