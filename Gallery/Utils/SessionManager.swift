//
//  SessionManager.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import Foundation

class SessionManager {
    
    private init() { }
    
    static let shared = SessionManager()
    
    @UserDefault("userId", defaultValue: nil)
    var userId: String?
    
    @UserDefault("appUserData", defaultValue: nil)
    private var appUserData: Data?
    
    @UserDefault("galleryData", defaultValue: nil)
    private var galleryData: Data?
    
    var appUserObject: AppUser? {
        get {
            guard let appUserData else { return nil }
            return try? JSONDecoder().decode(AppUser.self, from: appUserData)
        }
        set {
            appUserData = try? JSONEncoder().encode(newValue)
        }
    }
    
    var galleryObject: [Hit]? {
        get {
            guard let galleryData else { return nil }
            return try? JSONDecoder().decode([Hit].self, from: galleryData)
        }
        set {
            galleryData = try? JSONEncoder().encode(newValue)
        }
    }
    
}
