//
//  DataFactory.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation

public class DataFactory {
    
    public func provideApiService() -> ApiServices {
        return ApiServices()
    }
    
    public func provideServiceRouter() -> ServiceRouter {
        return ServiceRouter(apiServiceModel: ApiServiceModel(baseUrl: SchemeEnvironmentConfig.baseUrl, serviceEnvironment: SchemeEnvironmentConfig.schemeType, serviceVersion: SchemeEnvironmentConfig.schemeVersion))
    }
    
    public func provideEndpoint() -> EndPoint {
        return EndPointImpl(apiService: provideApiService(), serviceRouter: provideServiceRouter())
    }
    
}
