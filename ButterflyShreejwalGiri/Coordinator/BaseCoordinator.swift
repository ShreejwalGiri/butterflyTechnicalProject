//
//  BaseCoordinator.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 10/03/2024.
//

import Foundation
import RxSwift


public protocol Coordinator {
    func start()
    func purchaseDetailsView(item: Items)
    func popBack(to viewController: AnyClass)
}

class BaseCoordinator: Coordinator {
  
    
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    public final let disposeBag = DisposeBag()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func purchaseDetailsView(item: Items) {
        let vc = DetailsVc()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func popBack(to viewController: AnyClass) {
        self.navigationController.popViewController(animated: true)
    }
}
