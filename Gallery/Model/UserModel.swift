//
//  UserModel.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import Foundation

struct AppUser: Codable {
    var name: String?
    var email: String?
    var givenName: String?
    var profilePicUrl: URL?
}
