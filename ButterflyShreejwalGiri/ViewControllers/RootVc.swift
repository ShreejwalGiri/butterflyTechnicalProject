//
//  ViewController.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 07/03/2024.
//

import UIKit

class RootVc: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
    
    public func tableViewSetup() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    @objc func backNavClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

