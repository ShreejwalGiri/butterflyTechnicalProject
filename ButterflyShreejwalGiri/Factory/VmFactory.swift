//
//  VmFactory.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation

public class VmFactory {
    
    private final let dataFactory: DataFactory
    private final let domainFactory: DomainFactory

    init(dataFactory: DataFactory, domainFactory: DomainFactory) {
        self.dataFactory = dataFactory
        self.domainFactory = domainFactory
    }
    
    public func providePurchaseListVm() -> PurchaseVm {
        return PurchaseVm(purchaseUc: domainFactory.providePurchaseUc())
    }
}

