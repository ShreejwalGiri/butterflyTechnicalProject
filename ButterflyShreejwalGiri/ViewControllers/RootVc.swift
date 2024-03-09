//
//  ViewController.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 07/03/2024.
//

import UIKit

class RootVc: UIViewController {
    
    lazy var toolbar: DefaultToolBar = {
        let toolbarView = DefaultToolBar(toolbarTitle: "Test")
        return toolbarView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    open func setupViews() {
        
        self.view.backgroundColor = .white
        
        let mainStack = UIView().stack(
            toolbar,
            tableView,
            spacing: 20
        ).padLeft(16).padRight(16).padTop(16).padBottom(20)
        
        self.view.addSubview(mainStack)
        mainStack.fillSuperview()
        tableViewSetup()
    }
    
    open func setupActions() {
        self.toolbar.backButton.addTarget(self, action: #selector(backNavClick), for: .touchUpInside)
    }
    
    private func tableViewSetup() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    @objc func backNavClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

