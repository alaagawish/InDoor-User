//
//  Variants.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation


struct Variants:Hashable,Codable {
    
    var id: Int?
    var productId: Int?
    var title: String?
    var price: String?
    var sku: String?
    var position: Int?
    var inventoryPolicy: String?
    var compareAtPrice: String?
    var fulfillmentService: String?
    var inventoryManagement: String?
    var option1: String?
    var option2: String?
    var createdAt: String?
    var updatedAt: String?
    var taxable: Bool?
    var grams: Int?
    var weight: Int?
    var weightUnit: String?
    var inventoryItemId: Int?
    var inventoryQuantity: Int?
    var oldInventoryQuantity: Int?
    var requiresShipping: Bool?
    var adminGraphqlApiId: String?
    
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
    init(id: Int? = nil, productId: Int? = nil, title: String? = nil, price: String, sku: String? = nil, position: Int? = nil, inventoryPolicy: String? = nil, compareAtPrice: String? = nil, fulfillmentService: String? = nil, inventoryManagement: String? = nil, option1: String? = nil, option2: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, taxable: Bool? = nil, grams: Int? = nil, weight: Int? = nil, weightUnit: String? = nil, inventoryItemId: Int? = nil, inventoryQuantity: Int? = nil, oldInventoryQuantity: Int? = nil, requiresShipping: Bool? = nil, adminGraphqlApiId: String? = nil) {
        self.id = id
        self.productId = productId
        self.title = title
        self.price = price
        self.sku = sku
        self.position = position
        self.inventoryPolicy = inventoryPolicy
        self.compareAtPrice = compareAtPrice
        self.fulfillmentService = fulfillmentService
        self.inventoryManagement = inventoryManagement
        self.option1 = option1
        self.option2 = option2
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.taxable = taxable
        self.grams = grams
        self.weight = weight
        self.weightUnit = weightUnit
        self.inventoryItemId = inventoryItemId
        self.inventoryQuantity = inventoryQuantity
        self.oldInventoryQuantity = oldInventoryQuantity
        self.requiresShipping = requiresShipping
        self.adminGraphqlApiId = adminGraphqlApiId
    }
    init( productId: Int? ,title: String?,  price: String,  inventoryQuantity: Int? , oldInventoryQuantity: Int) {
        self.id = nil
        self.productId = productId
        self.title = title
        self.price = price
        self.sku = nil
        self.position = nil
        self.inventoryPolicy = nil
        self.compareAtPrice = nil
        self.fulfillmentService = nil
        self.inventoryManagement = nil
        self.option1 = nil
        self.option2 = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.taxable = nil
        self.grams = nil
        self.weight = nil
        self.weightUnit = nil
        self.inventoryItemId = nil
        self.inventoryQuantity = inventoryQuantity
        self.oldInventoryQuantity = oldInventoryQuantity
        self.requiresShipping = nil
        self.adminGraphqlApiId = nil
    }
}
