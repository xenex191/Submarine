//
//  Settings.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 20.06.2023.
//

import Foundation

class Setting: Codable {
    var submarine: ColorsView = .dark
    var name: String
    var level: Float
    var color: String
    
  init(name: String, level: Float, submarine: ColorsView, color: String) {
        self.name = name
        self.level = level
        self.submarine = submarine
        self.color = color
    }
    
    enum CodingKeys: String, CodingKey {
        case submarine
        case name
        case level
        case color
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        submarine = try container.decode(ColorsView.self, forKey: .submarine)
        name = try container.decode(String.self, forKey: .name)
        level = try container.decode(Float.self, forKey: .level)
        color = try container.decode(String.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(submarine, forKey: .submarine)
        try container.encode(name, forKey: .name)
        try container.encode(level, forKey: .level)
        try container.encode(color, forKey: .color)
    }
}
