//
//  ApiServiceModel.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import HandyJSON

public struct ApiServiceModel: HandyJSON {
    
    public var baseUrl: String = ""
    
    public init() {
    }
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public var errorDelegate: ApiServiceErrorDelegate?
    
    public init(errorDelegate: ApiServiceErrorDelegate? = nil) {
        self.errorDelegate = errorDelegate
    }

//    public func get<T: HandyJSON>(serviceModel: ServiceModel, model: T.Type) -> Observable<T> {
//        print("Request \u{1F601}===\u{2705}=====\u{1F601} \n" + serviceModel.url)
//        print("Method: GET")
//        
//        return RxAlamofire.requestData(.get, serviceModel.url)
//            .flatMap { (response, data) -> Observable<T> in
//                let jsonString = data.prettyPrintedJSONString
//                
//                print("RAW Response \u{1F601}====\u{2705}====\u{1F601} \n" + serviceModel.url)
//                print(jsonString)
//                print("END \u{1F601}========\u{1F601}")
//                
//                let statusResponse = self.checkStatus(statusCode: response.statusCode, jsonString: jsonString, model: T.self)
//                return statusResponse
//            }
//    }
    
    public func get<T: HandyJSON>(serviceModel: ServiceModel, model: T.Type) -> Observable<T> {
        print("Request \u{1F601}===\u{2705}=====\u{1F601} \n" + serviceModel.url)
        print("Method: GET")
        
        var headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
        ]
        
       
            headers.add(name: "Authorization", value: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDYwMzAwMzhmM2U4YTVkYzk2ZDJmYWZjZGJiOGMzNyIsInN1YiI6IjY1ZWUzMTdmZTIyZDI4MDE2MDIwZDlmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CBe9Az84GQsDpjM6QaFRBHKNpiuQ3OYp_gxDCRVgSh4")
        
        
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
    
}


extension Data {
    var prettyPrintedJSONString: NSString {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }
        
        return prettyPrintedString
    }
}

public extension Dictionary {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
           let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
}

