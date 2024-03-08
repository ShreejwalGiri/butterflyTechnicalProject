//
//  ViewController.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 07/03/2024.
//

import UIKit

class RootVc: UIViewController {
    
    lazy var welcomeLabel: UILabel  = {
        let lbl = UILabel()
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        // Configure welcomeLabel
        self.view.backgroundColor = .white
        welcomeLabel.text = "Welcome to shreejwal!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 20)
        
        // Add welcomeLabel to the view
        view.addSubview(welcomeLabel)
        
        // Add constraints for welcomeLabel (assuming you want it centered)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}

