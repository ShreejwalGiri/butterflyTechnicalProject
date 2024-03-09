//
//  AppFactory.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation

public class AppFactory {
    
    private var dataFactory: DataFactory?
    private var domainFactory: DomainFactory?
    private var vmFactory: VmFactory?
    
    private static var appFactory = AppFactory()
    
    public static func initialize() -> AppFactory {
        return appFactory
    }
    
    public func provideDataFactory() -> DataFactory {
        guard let dataFactory = dataFactory else {
            self.dataFactory = DataFactory()
            return self.dataFactory!
            
        }
        return dataFactory
    }
    
    public func provideDomainFactory() -> DomainFactory {
        guard let domainFactory = domainFactory else {
            self.domainFactory = DomainFactory(endpoint: provideDataFactory().provideEndpoint())
            return self.domainFactory!
            
        }
        return domainFactory
    }
    
    public func provideVmFactory() -> VmFactory {
        guard let vmFactory = vmFactory else {
            self.vmFactory = VmFactory(dataFactory: provideDataFactory(), domainFactory: provideDomainFactory())
            return self.vmFactory!
            
        }
        return vmFactory
    }
}
