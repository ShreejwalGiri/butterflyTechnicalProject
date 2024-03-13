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
    
    public static func showInfoAlert(
        vc: UIViewController?,
        title: String,
        message: String,
        buttonOneTitle: String? = "Ok",
        completionBtnOne: (() -> Void)? = nil,
        onCompletion: (() -> Void)? = nil
    ) {
        AlertHandler.provideHapticFeedback(style: .medium)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOne = UIAlertAction(title: buttonOneTitle, style: .default) { action in
            if let completion = completionBtnOne {
                completion()
            }
        }
        btnOne.setValue(ColorConfig.baseConfig.defaultWhite, forKey: "titleTextColor")
        alertController.addAction(btnOne)
        vc?.present(alertController, animated: true, completion: {
            onCompletion?()
        })
    }
}

