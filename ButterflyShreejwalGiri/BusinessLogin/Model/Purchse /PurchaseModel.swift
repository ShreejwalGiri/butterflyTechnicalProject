//
//  PurchaseModel.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import HandyJSON

public struct PurchaseModel: HandyJSON {
    
    public var id: String?
    public var success: Bool = false
    public var order_number: String?
    public var customer: String?
    public var items: [Items]?
    public var total: String?
    public var created_at: String?
    
    
    public init() {
    }
}

