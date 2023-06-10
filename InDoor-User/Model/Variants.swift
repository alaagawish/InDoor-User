//
//  Variants.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation

struct Variants:Hashable,Codable {
    
    let id: Int?
    let productId: Int?
    let title: String?
    let price: String
    let sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: String?
    let fulfillmentService: String?
    let inventoryManagement: String?
    let option1: String?
    let option2: String?
    let createdAt: String?
    let updatedAt: String?
    let taxable: Bool?
    let grams: Int?
    let weight: Int?
    let weightUnit: String?
    let inventoryItemId: Int?
    let inventoryQuantity: Int?
    let oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case title = "title"
        case price = "price"
        case sku = "sku"
        case position = "position"
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case option1 = "option1"
        case option2 = "option2"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable = "taxable"
        case grams = "grams"
        case weight = "weight"
        case weightUnit = "weight_unit"
        case inventoryItemId = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
    
}
