//
//  UIView+Extension.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var rounded: Bool {
        get {
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2 && layer.masksToBounds
        }
        set {
            if newValue {
                layer.cornerRadius = min(bounds.width, bounds.height) / 2
                layer.masksToBounds = true
            } else {
                layer.cornerRadius = 0
                layer.masksToBounds = false
            }
        }
    }
    
}
