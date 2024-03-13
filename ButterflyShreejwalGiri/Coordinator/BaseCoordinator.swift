//
//  BaseCoordinator.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 10/03/2024.
//

import Foundation
import RxSwift

public protocol Coordinator {
    func rootView() -> UIViewController
    func popBack(to viewController: AnyClass)
}

open class BaseCoordinator: Coordinator {
  
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    public final let disposeBag = DisposeBag()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func rootView() -> UIViewController {
        return UIViewController() 
    }
    
    public func popBack(to viewController: AnyClass) {
        self.navigationController.popViewController(animated: true)
    }
}
