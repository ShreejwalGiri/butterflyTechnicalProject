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
    func fetchSavedItem(data: [Items])
    func purchaseFailure(msg: String)
}

public extension PurchaseDelegate {
    func getPurchaseList(data: [PurchaseModel]) {}
    func fetchSavedItem(data: [Items]) {}
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
    
    func saveItem(data: Items) {
        self.purchaseUc.savedItems(data: data)
    }
    
    func fetchItem() {
        self.loading.onNext(true)
        disposeBag.insert(
            
            purchaseUc.fetchSavedItems().subscribe(onNext: {
                self.loading.onNext(false)
                if $0.isEmpty == false {
                    self.delegate?.fetchSavedItem(data: $0)
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
