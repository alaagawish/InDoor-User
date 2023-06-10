//
//  Response.swift
//  InDoor-User
//
//  Created by Alaa on 04/06/2023.
//

import Foundation
struct Response: Codable {
    let product: Product?
    let products: [Product]?
    let smartCollections: [SmartCollections]?
    let customCollections: [CustomCollections]?
    let currencies: [Currency]?
    let base: String?
    let rates: Rates?

    private enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
        case currencies = "currencies"
        case base = "base"
        case rates = "rates"
        case product = "product"
        case products = "products"
        case customCollections = "custom_collections"
    }
}
