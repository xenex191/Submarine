//
//  ViewController.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 29.03.2023.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func settingsAction(_ sender: UIButton) {
    guard let settings = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as?  SettingsViewController else { return }
    navigationController?.pushViewController(settings, animated: true)
    
  }
  @IBAction func settings(_ sender: UIButton) {
    guard let points = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as?
            SettingsViewController else {return}
    navigationController?.pushViewController(points, animated: true)
  }
  
  @IBAction func pointsAction(_ sender: UIButton) {
    guard let points = storyboard?.instantiateViewController(withIdentifier: "PointsViewController") as?
            PointsViewController else {return}
    navigationController?.pushViewController(points, animated: true)
  }
  
  @IBAction func toTheGame(_ sender: UIButton) {
    guard let game = storyboard?.instantiateViewController(withIdentifier:  "GameViewController") as? GameViewController else {return }
    navigationController?.pushViewController(game, animated: true)
  }
}

