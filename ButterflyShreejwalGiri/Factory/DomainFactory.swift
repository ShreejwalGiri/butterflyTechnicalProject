//
//  DomainFactory.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation

public class DomainFactory {
    
    private final var endpoint: EndPoint
    
    private var purchaseUc: PurchaseUc?
  
    
    init(endpoint: EndPoint) {
        self.endpoint = endpoint
    }
    
    public func providePurchaseRepo() -> PurchaseRepo {
        return PurchaseRepoImpl(endpoint: self.endpoint)
    }
    
    public func providePurchaseUc() -> PurchaseUc {
        return PurchaseUc(purchaseRepo: self.providePurchaseRepo())
    }
}
