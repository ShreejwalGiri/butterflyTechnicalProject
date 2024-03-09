//
//  ApiServiceRouter.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public struct ServiceModel {
    var url: String
}

public enum ServiceName {
    case purchaseList
}

public class ServiceRouter {
    var apiServiceModel: ApiServiceModel
    
    public init(apiServiceModel: ApiServiceModel) {
        self.apiServiceModel = apiServiceModel
    }
    
    
    internal func getService(name: ServiceName) -> Observable<ServiceModel> {
        var url = ""
        
        switch name {
        case .purchaseList:
            url = "https://mpa25bed2ce5c3e3d486.free.beeceptor.com/data" //"https://my-json-server.typicode.com/butterfly-systems/sample-data/purchase_orders"
        }
        
        let serviceModel = ServiceModel(url: url)
        return Observable.just(serviceModel)
    }
}
