//
//  WebService.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import Foundation

class WebService {
    
    class func getResponseFromServer<E: Codable, C: Codable>(method: ApiMethod, endPoint: APIType, requestModel: E? = nil, responseModel: C.Type, _ completion: @escaping ((_ status: Bool, _ message: String?, _ response: C?) -> Void)) {
        guard var url = URL(string: AppEnvironment.baseURL.rawValue + endPoint.rawValue) else {
            completion(false, "Invalid url", nil)
            return
        }
        
        if method == .get {
            if let data = requestModel?.asData, let paramDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
//                url.append(queryItems: paramDict.compactMap({URLQueryItem(name: $0.key, value: $0.value as? String)}))
                if let urlWithParam = url.appendingQueryParameters(paramDict) {
                    url = urlWithParam
                }
            }
        }
        let apiRequest = URLRequest(url: url)
        print("API Request", apiRequest)
        
        if !Reachability.isConnectedToNetwork() {
            print(self, "No Internet")
            return
        }
        
        URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(false, error?.localizedDescription, nil)
                    return
                }
                
                guard let data else {
                    completion(false, "Data not found", nil)
                    return
                }
                
                guard let object = try? JSONDecoder().decode(C.self, from: data) else {
                    completion(false, "Data not parse", nil)
                    return
                }
                                
                completion(true, "Success", object)
            }
        }.resume()
    }
    
}

extension URL {
    
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }

        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }

        return components.url
    }
    
}
