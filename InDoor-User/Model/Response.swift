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
    let orders: [Orders]?
    let order: Orders?
    var priceRules: [PriceRule]?
    var priceRule: PriceRule?
    var discountCodes: [DiscountCodes]?
    var discountCode: DiscountCodes?
    var inventoryLevel: InventoryLevel?
    var inventoryItem: InventoryItem?
    
    private enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
        case currencies = "currencies"
        case base = "base"
        case rates = "rates"
        case product = "product"
        case products = "products"
        case orders = "orders"
        case order = "order"
        case customCollections = "custom_collections"
        case customer,customers, addresses, customer_address
        case inventoryItem = "inventory_item"
        case inventoryLevel = "inventory_level"
        case discountCode = "discount_code"
        case discountCodes = "discount_codes"
        case priceRules = "price_rules"
        case priceRule = "price_rule"
    }
}
