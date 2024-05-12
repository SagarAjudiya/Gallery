//
//  GoogleSignIn.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import GoogleSignIn

class GoogleSignIn {
    
    class func signIn(from viewController: UIViewController, _ completion: @escaping (Result<GIDGoogleUser, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let signInResult else {
                completion(.failure(GoogleSignInError.resultNotFound))
                return
            }
            
            completion(.success(signInResult.user))
        }
    }
    
    class func isCurrentUser() -> Bool {
        if GIDSignIn.sharedInstance.currentUser != nil {
            return true
        }
        return false
    }
    
    class func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
}

enum GoogleSignInError: String, Error {
    case resultNotFound = "Sign-in result is nil"
}
