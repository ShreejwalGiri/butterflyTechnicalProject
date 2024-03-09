//
//  PurchaseUc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public class PurchaseUc {
    
    private let purchaseRepo: PurchaseRepo
    
    init(purchaseRepo: PurchaseRepo) {
        self.purchaseRepo = purchaseRepo
    }
    
    public func getPurchaseData() -> Observable<[PurchaseModel]> {
        self.purchaseRepo.getPurchasedData().map { purchaseModel in
                return purchaseModel
        }
    }
}
