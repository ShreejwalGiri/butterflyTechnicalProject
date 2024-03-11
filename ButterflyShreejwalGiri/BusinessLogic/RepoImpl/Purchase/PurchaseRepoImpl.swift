//
//  PurchaseRepoImpl.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public class PurchaseRepoImpl: PurchaseRepo {
    
    var endpoint: EndPoint
    
    public init(endpoint: EndPoint) {
        self.endpoint = endpoint
    }
    
    public func getPurchasedData() -> Observable<[PurchaseModel]> {
        return self.endpoint.getPurchaseList()
    }
}
