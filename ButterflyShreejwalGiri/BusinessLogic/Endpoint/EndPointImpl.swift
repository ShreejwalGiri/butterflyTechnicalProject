//
//  EndPointImpl.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public class EndPointImpl: EndPoint {
    
    var apiService: ApiServices
    var serviceRouter: ServiceRouter
    
    init(apiService: ApiServices, serviceRouter: ServiceRouter) {
        self.apiService = apiService
        self.serviceRouter = serviceRouter
    }
    
    public func getPurchaseList() -> Observable<[PurchaseModel]> {
        return serviceRouter.getService(name: .purchaseList).flatMap {
            return self.apiService.getPurchaseModels(serviceModel: $0).map { purchaseModel in
                return purchaseModel
            }
        }
    }
    
    public func getMovieDetails() -> Observable<MovieDetails> {
        return serviceRouter.getService(name: .movieDetails).flatMap {
            return self.apiService.get(serviceModel: $0, model: MovieDetails.self).map { purchaseModel in
                return purchaseModel
            }
        }
    }
    
    public func getMovieList() -> Observable<MovieList> {
        return serviceRouter.getService(name: .movieList).flatMap {
            return self.apiService.get(serviceModel: $0, model: MovieList.self).map { purchaseModel in
                return purchaseModel
            }
        }
    }
    
}
