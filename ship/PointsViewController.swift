//
//  PointsViewController.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 29.03.2023.
//

import UIKit

class PointsViewController: UIViewController {
  
  // MARK: @IBOutlet
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: @IBOutlet
  let userDefaults = UserDefaults.standard.value([Result].self, forKey: "ResultKey")
  var result: [Result] = []
 
  
  // MARK: lifeCircle funcs
  override func viewDidLoad() {
    super.viewDidLoad()
    editTableView()
    result = userDefaults ?? [Result]()
    result.sort { $0.time > $1.time }
  }
  
  func editTableView() {
    tableView.backgroundColor = .clear
    tableView.separatorColor = .clear
    tableView.layer.borderColor = CGColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 1)
    tableView.layer.borderWidth = 2
    tableView.layer.cornerRadius = 10
    tableView.allowsSelection = false
    tableView.estimatedRowHeight = 36
    tableView.rowHeight = 36
    tableView.showsVerticalScrollIndicator = false
    tableView.alwaysBounceVertical = true
  }
  
  // MARK: @IBAction
  @IBAction func backAction(_ sender: UIButton) {
    guard let gameView = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as?  GameViewController else { return }
    navigationController?.pushViewController(gameView, animated: true)
  }
}

// MARK: extension
extension PointsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return result.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell" , for: indexPath) as?
              HeaderTableViewCell else {return UITableViewCell()}
      cell.contentView.backgroundColor = .clear
      cell.backgroundColor = .clear
      return cell
    }
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PiontsTableViewCell" , for: indexPath) as? PiontsTableViewCell else {return UITableViewCell()}
    cell.dateForLabels(from: result[indexPath.row])
    cell.contentView.backgroundColor = .clear
    cell.backgroundColor = .clear
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
      result.remove(at: indexPath.row)
      tableView.reloadData()
      UserDefaults.standard.set(encodable: result, forKey: "ResultKey")
    }
  }
}

