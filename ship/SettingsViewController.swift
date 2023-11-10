//
//  SettingsViewController.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 29.03.2023.
//

import UIKit

enum ColorsView: String, Codable{
  case grey
  case dark
}

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var viewMenu: UIImageView!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var textField: UITextField!
  let buttonBack = UIButton(frame: CGRect(x: 50, y: 20, width: 45, height: 42))
  var settings: Setting?
  var submarineSelected: ColorsView = .dark
  
  var indexCount = 0
  
  let imageView = ["submarine1","submarine2","submarine3"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadSettings()
    slider.minimumValue = 1.0
    slider.maximumValue = 3.0
    slider.value = settings?.level ?? 0.0
    let image = UIImage(named: "restart")
    buttonBack.setBackgroundImage(image, for: .normal)
    buttonBack.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    view.addSubview(buttonBack)
  }
  
  func settngs(color: ColorsView) {
    switch submarineSelected {
    case .dark:
      if indexCount > 0 {
        indexCount -= 1
      } else {
        indexCount = imageView.count - 1
      }
      viewMenu.image = UIImage(named: imageView[indexCount])
    case .grey:
      if indexCount < imageView.count - 1 {
        indexCount += 1
      } else {
        indexCount = 0
      }
      viewMenu.image = UIImage(named: imageView[indexCount])
    }
    
  }
  @objc func backAction() {
    navigationController?.popToRootViewController(animated: true)
    guard let text = textField.text else {return}
    settings = Setting(name: text, level: slider.value , submarine: submarineSelected, color: imageView[indexCount] )
    
    UserDefaults.standard.set(encodable: settings, forKey: "key")
  }
  @IBAction func save() {
    settngs(color: .dark)
  }
  @IBAction func load() {
    settngs(color: .grey)
  }
  
  func loadDefaults() {
    guard let defaults = UserDefaults.standard.value(Setting.self, forKey: "key") else {
      return
    }
    settings = defaults
  }
  
  func loadSettings() {
    loadDefaults()
    guard let tempSettings = settings else { return }
    submarineSelected = tempSettings.submarine

    guard let image = UIImage(named: settings?.color ?? "shipSmallDark") else { return }
    viewMenu.image = image
    textField.text = tempSettings.name
    slider.value = tempSettings.level
  }
}

extension SettingsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    hideKeyboard()
    return true
  }
  
  func hideKeyboard() {
    textField.resignFirstResponder()
  }
}
