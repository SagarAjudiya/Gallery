//
//  ProfileVC.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblGivenName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserData()
    }

    // MARK: - IBAction
    @IBAction func btnClose(_ sender: UIButton) {
        goBack()
    }
    
    @IBAction func btnLogoutTap(_ sender: UIButton) {
        SessionManager.shared.userId = nil
        SessionManager.shared.appUserObject = nil
        SessionManager.shared.galleryObject = nil
        GoogleSignIn.signOut()
        guard let loginVC = getInstance(LoginVC.self) else { return }
        loginVC.setRootViewControllerWithNavigation()
    }
    
}

// MARK: - Function
extension ProfileVC {
    
    private func setUserData() {
        let user = SessionManager.shared.appUserObject
        lblName.text = user?.name
        lblEmail.text = user?.email
        lblGivenName.text = user?.givenName
        imgProfile.loadImage(user?.profilePicUrl?.absoluteString)
    }
    
}
