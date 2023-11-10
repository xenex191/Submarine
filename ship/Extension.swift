//
//  Extension.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 09.06.2023.
//

import Foundation
import UIKit

extension UIButton {
  
  func layerButton() {
    self.layer.cornerRadius = 15
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: 0, height: 10)
    layer.shadowRadius = 10
    
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
  }
}
