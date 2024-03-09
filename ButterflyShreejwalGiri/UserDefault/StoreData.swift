//
//  StoreData.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation

open class StoreData {
    let userDefaults = UserDefaults.standard
    
    public func storeData<T>(value: T, key: String) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    public func getStoreData<T>(storeType: T.Type, key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }
    
    public func removeStoreData(key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    public init() {
    }
}
