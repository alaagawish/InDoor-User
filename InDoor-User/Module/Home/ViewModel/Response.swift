//
//  Response.swift
//  InDoor-User
//
//  Created by Alaa on 04/06/2023.
//

import Foundation
struct Response: Codable {
    let product: Product?
    let smartCollections: [SmartCollections]?

    private enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
        case product = "product"
    }
}
