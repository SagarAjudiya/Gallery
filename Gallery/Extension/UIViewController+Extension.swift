//
//  UIViewController+Extension.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

extension UIViewController {
    
    func getInstance<V: UIViewController>(_ vc: V.Type) -> V? {
        return storyboard?.instantiateViewController(identifier: V.className) as? V
    }
    
    func navigateTo(_ viewController: UIViewController, animated: Bool = false) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func goBack() {
        if navigationController?.children.count == 1 {
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func setRootViewControllerWithNavigation() {
        let rootViewController = self
        let navigationController = UINavigationController(rootViewController: rootViewController)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    
}

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
}
