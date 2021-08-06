//
//  Character.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import Foundation

struct Character: Codable {
    
    var identifier: Int
    var name: String
    var birthday: String
    var occupation: [String]
    var imgURLString: String
    var status: String
    var nickname: String
    var appearance: [Int]
    var portrayed: String
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "char_id"
        case imgURLString = "img"
        case name
        case birthday
        case occupation
        case status
        case nickname
        case appearance
        case portrayed
        case category
    }
}
