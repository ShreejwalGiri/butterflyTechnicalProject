//
//  BaseVm.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public class BaseVm {
    
    public final let disposeBag = DisposeBag()
    
    public var errorMsg: String = "Error Processing Request Please Try Again"
    public var noDataFound = "No Data Found"
    public var successMsg: String = "Success"
    
    public let loading  : PublishSubject<Bool> = PublishSubject()
    public let disableloading  : PublishSubject<Bool> = PublishSubject()
    public let error    : PublishSubject<String> = PublishSubject()
}

protocol ModelWithFieldErrors {
    associatedtype FieldError
    var fieldErrors: [FieldError]? { get }
}
