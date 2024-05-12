//
//  GalleryVC.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import UIKit

class GalleryVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imgGallery: UIImageView!
    
    // MARK: - Variable
    var image: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        imgGallery.loadImage(image)
    }

}
