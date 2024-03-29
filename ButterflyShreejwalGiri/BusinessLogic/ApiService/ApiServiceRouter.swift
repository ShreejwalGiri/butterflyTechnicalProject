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
    case movieList(Int)
    case movieDetails(Int)
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
            url = "https://mp84ea0cc863451cb24d.free.beeceptor.com/data"
            
        case .movieList(let page):
           url = SchemeEnvironmentConfig.baseUrl + "discover/movie?include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}"
          
        case .movieDetails(let movieId):
            url = SchemeEnvironmentConfig.baseUrl + "/movie/\(movieId)?api_key=ed6030038f3e8a5dc96d2fafcdbb8c37"
        }
        
        let serviceModel = ServiceModel(url: url)
        return Observable.just(serviceModel)
    }
}
