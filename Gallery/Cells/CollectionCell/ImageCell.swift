//
//  ImageCell.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imgGallery: UIImageView!
    @IBOutlet weak var vwMain: UIView!
    
    var galleryResponse: Hit? {
        didSet {
            imgGallery.loadImage(galleryResponse?.largeImageURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
