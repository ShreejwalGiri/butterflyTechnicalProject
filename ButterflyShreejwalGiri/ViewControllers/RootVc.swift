//
//  ViewController.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 07/03/2024.
//

import UIKit
import RxCocoa
import RxSwift
import Reachability

class RootVc: UIViewController {
    
    public final let disposeBag: DisposeBag = DisposeBag()
    
    lazy var overlayView: UIView = UIView(backgroundColor: UIColor.black.withAlphaComponent(0.4))
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkConnetionCheck()
        setupViews()
    }
    
    public func networkConnetionCheck() {
        reachability.whenUnreachable = { _ in
            AlertHandler.showInfoAlert(vc: self, title: "Warning!!", message: "Oops! It seems like you're currently offline and using offline mode. Please note that some features may be limited or unavailable. You can continue to browse offline content, and once you're back online, full functionality will be restored. Thank you for your understanding!")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    open func setupViews() {
        
        self.view.backgroundColor = .systemBackground
        
        let mainStack = UIView().stack(
            tableView,
            spacing: 20
        ).padLeft(16).padRight(16).padTop(16).padBottom(20)
        
        self.view.addSubview(mainStack)
        mainStack.fillSuperview()
        tableViewSetup()
    }
    
    open func observe(loading: PublishSubject<Bool>) {
        loading
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { loading in
                if loading {
                    self.showLoader()
                } else {
                    self.hideLoader()
                }
            }
            ).disposed(by: disposeBag)
    }
    
    open func showLoader() {
        guard let navigationController = navigationController else { return }
        navigationController.view.addSubview(overlayView)
        overlayView.fillSuperview()
        navigationController.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: navigationController.view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: navigationController.view.centerYAnchor).isActive = true
        view.isUserInteractionEnabled = false
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        activityIndicatorView.startAnimating()
    }
    
    open func hideLoader() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        overlayView.removeFromSuperview()
    }
    
    public lazy var activityIndicatorView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            view.style = .medium
        } else {
            view.style = .white
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()
    
    public func tableViewSetup() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    @objc func backNavClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

