//
//  APIType.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import Foundation

enum AppEnvironment: String {
    case baseURL = "https://pixabay.com/api/"
}

enum APIType: String {
    case image = ""
}

enum ApiMethod: String {
    case get = "GET"
    case post = "POST"
}

extension Encodable {
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}


typealias LoaderClosure = ((_ isLoading: Bool) -> Void)
typealias ApiClosure <C: Codable> = ((_ status: Bool, _ message: String?,_ data: C?) -> Void)
