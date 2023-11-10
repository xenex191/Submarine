//
//  User.swift
//  ship
//
//  Created by Дмитрий Абдуллаев on 18.06.2023.
//

class Result: Codable {
    var nickName: String
    var time: Int
    var date: String
    var color: String
  
  init(nickName: String, time: Int, date: String, color: String) {
        self.nickName = nickName
        self.time = time
        self.date = date
        self.color = color
       
    }
    
    enum CodingKeys: String, CodingKey {
        case nickName
        case time
        case date
        case color
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        nickName = try container.decode(String.self, forKey: .nickName)
        time = try container.decode(Int.self, forKey: .time)
        color = try container.decode(String.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(nickName, forKey: .nickName)
        try container.encode(time, forKey: .time)
        try container.encode(date, forKey: .date)
        try container.encode(color, forKey: .color)
    }
}

