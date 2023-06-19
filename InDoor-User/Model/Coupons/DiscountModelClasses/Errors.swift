//
//  Errors.swift
//  InDoor-Admin
//
//  Created by Ahmed on 18/06/2023.
//

import Foundation

struct Errors: Codable {

    var code: [String]?

    private enum CodingKeys: String, CodingKey {
        case code = "code"
    }

}
