//
//  PurchaseUc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public class PurchaseUc {
    
    private final let disposeBag: DisposeBag = DisposeBag()
    private let purchaseRepo: PurchaseRepo
    
    private var savedItems = [Items]()
    
    private var savedItemSubject: BehaviorSubject = BehaviorSubject<[Items]>(value: [])
    
    init(purchaseRepo: PurchaseRepo) {
        self.purchaseRepo = purchaseRepo
    }
    
    public func getPurchaseData() -> Observable<[PurchaseModel]> {
        self.purchaseRepo.getPurchasedData().map { purchaseModel in
                return purchaseModel
        }
    }
    
    public func savedItems(data: Items) {
        self.savedItems.append(data)
        refreshItems()
    }
    
    public func fetchSavedItems() -> Observable<[Items]> {
        do {
            _ = try savedItemSubject.value()
            refreshItems()
             return savedItemSubject.asObservable()
         } catch {
             return savedItemSubject.asObservable()
         }
    }
    
    func refreshItems() {
        Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { _ in
                return Observable.just(self.savedItems ?? [])
            }
            .subscribe(onNext: {
                self.savedItemSubject.onNext($0)
            }, onError: {
                print($0.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
  
}
