//
//  PurchaseRepo.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public protocol PurchaseRepo {
    func getPurchasedData() -> Observable<[PurchaseModel]>
}
