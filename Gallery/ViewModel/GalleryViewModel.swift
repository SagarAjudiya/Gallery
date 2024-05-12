//
//  GalleryViewModel.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import Foundation

class GalleryViewModel {
    
    func getGalleryListApi(request: GalleryRequest?, showLoader: @escaping LoaderClosure, apiClosure: @escaping ApiClosure<GalleryResponse>) {
        showLoader(true)
        
        WebService.getResponseFromServer(method: .get, endPoint: .image, requestModel: request, responseModel: GalleryResponse.self) { status, message, response in
            showLoader(false)
            apiClosure(status, message, response)
        }
    }
    
}
