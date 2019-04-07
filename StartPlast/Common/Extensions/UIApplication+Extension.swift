//
//  UIDevice+extension.swift
//  StartPlast
//
//  Created by Viktor Rudyk on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//
import UIKit

extension UIApplication {
    
    static func topViewController() -> UIViewController {
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                
            }
            return topController
        }
        
        return rootViewController!
    }
}

