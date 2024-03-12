//
//  AlertHandler.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import Foundation
import UIKit
import LocalAuthentication

open class AlertHandler {
    
    public static func provideHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if #available(iOS 10.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
            feedbackGenerator.prepare()
            feedbackGenerator.impactOccurred()
        }
    }
    
    public static func showFailureAlert(vc: UIViewController?, title: String? = "Failure", message: String, completion: (() -> Void)? = nil) {
        
        AlertHandler.provideHapticFeedback(style: .heavy)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            if let completion = completion {
                completion()
            }
        }
        okAction.setValue(ColorConfig.baseConfig.defaultBlack, forKey: "titleTextColor")
        alertController.addAction(okAction)
        vc?.present(alertController, animated: true, completion: nil)
    }
}

