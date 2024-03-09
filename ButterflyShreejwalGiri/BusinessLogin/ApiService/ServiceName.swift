//
//  ServiceName.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation

internal enum serviceName {
  case purchaseService(name: purchase_service)
}

internal enum purchase_service {
    case purchase_order_list
}

struct purchase_endpoint {
    static let purchase_order = "sample-data/purchase_orders"
}
