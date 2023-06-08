//
//  Rules.swift
//  InDoor-User
//
//  Created by Alaa on 04/06/2023.
//

import Foundation

struct Rules: Codable {
    
    let column: String?
    let relation: String?
    let condition: String?
    
    private enum CodingKeys: String, CodingKey {
        case column = "column"
        case relation = "relation"
        case condition = "condition"
    }
    
}
