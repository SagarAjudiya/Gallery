//
//  SplashVC.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

class SplashVC: UIViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setRoot()
        }
    }

}

// MARK: - Function
extension SplashVC {
    
    private func setRoot() {
        if SessionManager.shared.userId?.isEmpty == false {
            guard let homeVC = getInstance(HomeVC.self) else { return }
            homeVC.setRootViewControllerWithNavigation()
        } else {
            guard let loginVC = getInstance(LoginVC.self) else { return }
            loginVC.setRootViewControllerWithNavigation()
        }
    }
    
}
