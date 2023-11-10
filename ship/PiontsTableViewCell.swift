//
//  PiontsTableViewCell.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 17.07.2023.
//

import UIKit

class PiontsTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var colorLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  func dateForLabels(from string: Result) {
    nameLabel.text = string.nickName
    timeLabel.text = string.time.description
    dateLabel.text = string.date
    colorLabel.text = string.color
  } 
}
