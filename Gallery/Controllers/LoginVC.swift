//
//  LoginVC.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var btnGoogle: UIButton!
    
    // MARK: - Variable
    private var appUser = AppUser()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    // MARK: - IBAction
    @IBAction func btnGoogleTap(_ sender: UIButton) {
        GoogleSignIn.signIn(from: self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                SessionManager.shared.userId = user.userID
                appUser.email = user.profile?.email
                appUser.name = user.profile?.name
                appUser.givenName = user.profile?.givenName
                appUser.profilePicUrl = user.profile?.imageURL(withDimension: 320)
                SessionManager.shared.appUserObject = appUser
                guard let homeVC = self.getInstance(HomeVC.self) else { return }
                homeVC.setRootViewControllerWithNavigation()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
