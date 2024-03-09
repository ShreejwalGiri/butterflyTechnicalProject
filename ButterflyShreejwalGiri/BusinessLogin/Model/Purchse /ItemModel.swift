//
//  ItemModel.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import HandyJSON

public struct Items: HandyJSON {
    
    public var id: String?
    public var product: String?
    public var quantity: String?
    public var price: String?
  
    public init() {
    }
}
