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
    let customer: User?
    let customers: [User]?
    let addresses: [Address]?
    let customer_address: Address?
    let draftOrder: DraftOrder?
    let orders: [Orders]?
    private enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
        case currencies = "currencies"
        case base = "base"
        case rates = "rates"
        case product = "product"
        case products = "products"
        case orders = "orders"
        case customCollections = "custom_collections"
        case draftOrder = "draft_order"
        case customer,customers, addresses, customer_address
    }
}
