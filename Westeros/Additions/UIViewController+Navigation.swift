//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Javier Finez on 20/09/2018.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
