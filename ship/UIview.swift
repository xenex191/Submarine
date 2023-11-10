//
//  UIview.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 16.06.2023.
//

import Foundation
import UIKit

extension UIImageView {
  func createOctopus() {
    self.contentMode = .scaleAspectFill
    self.image = UIImage(named: "octopus")
  }
  func createBottomShip() {
    self.contentMode = .scaleAspectFit
    self.frame = CGRect(x: 150, y: 250, width: 130, height: 130)
  }
  func createShip() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "ship")
  }
  func createShark() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "shark")
  }
  func createFish() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "fish3")
  }
  func createFish1() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "fish1")
  }
  func createFish2() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "fish2")
  }
  func createDorry() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "dory")
  }
  func createBallFish() {
    self.contentMode = .scaleAspectFit
    self.image = UIImage(named: "ballFish")
  }
}


