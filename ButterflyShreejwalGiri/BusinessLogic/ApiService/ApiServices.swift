//
//  ApiserviceVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 08/03/2024.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import HandyJSON

public enum MyError: Error {
    case deserializationError
}

public protocol ApiServiceErrorDelegate {
    func sessionTimeOut()
}

public class ApiServices {
    
    let disposeBag = DisposeBag()
    let userDefault = StoreData()
    let userDefaultConstants = UserDefaultConstants.self
    
    public var errorDelegate: ApiServiceErrorDelegate?
    
    public init(errorDelegate: ApiServiceErrorDelegate? = nil) {
        self.errorDelegate = errorDelegate
    }
    
    
    public func get<T: HandyJSON>(serviceModel: ServiceModel, model: T.Type) -> Observable<T> {
        print("Request \u{1F601}===\u{2705}=====\u{1F601} \n" + serviceModel.url)
        print("Method: GET")
        
        var headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
        ]
        
        headers.add(name: "Authorization", value: SchemeEnvironmentConfig.authorizationToken)
        
        return RxAlamofire.requestData(.get, serviceModel.url, headers: headers)
            .flatMap { (response, data) -> Observable<T> in
                let jsonString = data.prettyPrintedJSONString
                
                print("RAW Response \u{1F601}====\u{2705}====\u{1F601} \n" + serviceModel.url)
                print(jsonString)
                print("END \u{1F601}========\u{1F601}")
                
                let statusResponse = self.checkStatus(statusCode: response.statusCode, jsonString: jsonString, model: T.self)
                return statusResponse
            }
    }
    
    public func getPurchaseModels(serviceModel: ServiceModel) -> Observable<[PurchaseModel]> {
        print("Request \u{1F601}===\u{2705}=====\u{1F601} \n" + serviceModel.url)
        print("Method: GET")
        
        return RxAlamofire.requestData(.get, serviceModel.url)
            .flatMap { (response, data) -> Observable<[PurchaseModel]> in
                let jsonString = String(data: data, encoding: .utf8) ?? ""
                
                print("RAW Response \u{1F601}====\u{2705}====\u{1F601} \n" + serviceModel.url)
                print(jsonString)
                print("END \u{1F601}========\u{1F601}")
                
                let purchaseModels: [PurchaseModel] = self.parseJSONToPurchaseModels(jsonString: jsonString)
                return Observable.just(purchaseModels)
            }
    }
    
    func parseJSONToPurchaseModels(jsonString: String) -> [PurchaseModel] {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Invalid JSON string")
            return []
        }
        
        do {
            guard let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] else {
                print("Failed to parse JSON data")
                return []
            }
            
            var purchaseModels: [PurchaseModel] = []
            
            for jsonObject in jsonArray {
                if let purchaseModel = PurchaseModel.deserialize(from: jsonObject) {
                    purchaseModels.append(purchaseModel)
                }
            }
            
            return purchaseModels
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
    private func checkStatus<T: HandyJSON>(statusCode: Int, jsonString: NSString, model: T.Type) -> Observable<T> {
        if 200..<300 ~= statusCode {
            let dataParamsMergeValue = returnDictionary(jsonString: jsonString)
            
            guard let model = JSONDeserializer<T>.deserializeFrom(json: dataParamsMergeValue as String) else {
                return Observable.error(MyError.deserializationError)
            }
            
            print("MODEL Response \u{1F601}========\u{1F601} \n")
            print(model.toJSON()?.printAsJSON() ?? "")
            print("END \u{1F601}========\u{1F601}")
            
            return Observable.just(model)
        } else {
            
            let errorMsg = errorHandler(statusCode: statusCode, jsonString: jsonString, model: model)
            return errorMsg
        }
    }
    
    
    private func returnDictionary(jsonString: NSString) -> NSString {
        
        guard let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue) else {
            print("Invalid JSON string")
            return ""
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            print("Failed to parse JSON data")
            return ""
        }
        
        var finaDict: [String: Any] = jsonObject
        
        if let dataDictValue = finaDict[paramsConstants.data] as? [String: Any] {
            var finalDataDictVal = dataDictValue
            let dataMessage = finalDataDictVal[paramsConstants.message]
            finalDataDictVal.removeValue(forKey: paramsConstants.message)
            finaDict.merge(finalDataDictVal) { _, _ in
            }
            finaDict.removeValue(forKey: paramsConstants.data)
            finaDict["dataMessage"] = dataMessage
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: finaDict, options: [.prettyPrinted])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return NSString(string: jsonString)
            } else {
                return NSString(string: "")
            }
        } catch {
            return NSString(string: "")
        }
    }
    
    private func errorHandler<T: HandyJSON>(statusCode: Int, jsonString: NSString, model: T.Type) -> Observable<T> {
        
        
        guard let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue) else {
            print("Invalid JSON string")
            return Observable.error(MyError.deserializationError)
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            print("Failed to parse JSON data")
            return Observable.error(MyError.deserializationError)
        }
        
        var finaDict: [String: Any] = jsonObject
        finaDict["success"] = false as Any
        finaDict["statusCode"] = statusCode as Any
        
        let errorMsg =
        """
        {
          "success": "false",
          "message": "Error Processing request!"
        }
        """
        
        guard let staticErrorModel = JSONDeserializer<T>.deserializeFrom(json: errorMsg as String) else {
            return Observable.error(MyError.deserializationError)
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: finaDict, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                
                guard let dynamicErrorMsg = JSONDeserializer<T>.deserializeFrom(json: jsonString as String) else {
                    return Observable.error(MyError.deserializationError)
                }
                return Observable.just(dynamicErrorMsg)
            } else {
                return Observable.just(staticErrorModel)
            }
        } catch {
            return Observable.just(staticErrorModel)
        }
    }
}
