//
//  LineItems.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation

struct LineItems: Codable {
    
    var id: Int?
    var adminGraphqlApiId: String?
    var fulfillableQuantity: Int?
    var fulfillmentService: String?
    var giftCard: Bool?
    var grams: Int?
    var name: String?
    var price: String?
    var priceSet: TotalPriceSet?
    var productExists: Bool?
    var productId: Int?
    var quantity: Int?
    var requiresShipping: Bool?
    var sku: String?
    var taxable: Bool?
    var title: String?
    var totalDiscount: String?
    var totalDiscountSet: TotalPriceSet?
    var variantId: Int?
    var variantInventoryManagement: String?
    var variantTitle: String?
    var vendor: String?
    var properties: [Properties]?
    
//    init(price: String?, quantity: Int?, title: String?) {
//        self.id = nil
//        self.adminGraphqlApiId = nil
//        self.fulfillableQuantity = nil
//        self.fulfillmentService = nil
//        self.giftCard = nil
//        self.grams = nil
//        self.name = nil
//        self.price = price
//        self.priceSet = nil
//        self.productExists = nil
//        self.productId = nil
//        self.quantity = quantity
//        self.requiresShipping = nil
//        self.sku = nil
//        self.taxable = nil
//        self.title = title
//        self.totalDiscount = nil
//        self.totalDiscountSet = nil
//        self.variantId = nil
//        self.variantInventoryManagement = nil
//        self.variantTitle = nil
//        self.vendor = nil
//        self.properties = nil
//    }
//    init(productId: Int?,price: String?, quantity: Int?,title: String?, properties: [Properties]?) {
//        self.id = nil
//        self.adminGraphqlApiId = nil
//        self.fulfillableQuantity = nil
//        self.fulfillmentService = nil
//        self.giftCard = nil
//        self.grams = nil
//        self.name = nil
//        self.priceSet = nil
//        self.productExists = nil
//        self.quantity = quantity
//        self.price = price
//        self.productId = productId
//        self.variantId = nil
//        self.requiresShipping = nil
//        self.sku = nil
//        self.taxable = nil
//        self.title = title
//        self.totalDiscount = nil
//        self.totalDiscountSet = nil
//        self.variantInventoryManagement = nil
//        self.variantTitle = nil
//        self.vendor = nil
//        self.properties = properties
//    }
//    init(price: String?, quantity: Int?, title: String?, properties: [Properties]) {
//        self.id = nil
//        self.adminGraphqlApiId = nil
//        self.fulfillableQuantity = nil
//        self.fulfillmentService = nil
//        self.giftCard = nil
//        self.grams = nil
//        self.name = nil
//        self.price = price
//        self.priceSet = nil
//        self.productExists = nil
//        self.productId = nil
//        self.quantity = quantity
//        self.requiresShipping = nil
//        self.sku = nil
//        self.taxable = nil
//        self.title = title
//        self.totalDiscount = nil
//        self.totalDiscountSet = nil
//        self.variantId = nil
//        self.variantInventoryManagement = nil
//        self.variantTitle = nil
//        self.vendor = nil
//        self.properties = properties
//    }
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case fulfillableQuantity = "fulfillable_quantity"
        case fulfillmentService = "fulfillment_service"
        case giftCard = "gift_card"
        case grams = "grams"
        case name = "name"
        case price = "price"
        case priceSet = "price_set"
        case productExists = "product_exists"
        case productId = "product_id"
        case quantity = "quantity"
        case requiresShipping = "requires_shipping"
        case sku = "sku"
        case taxable = "taxable"
        case title = "title"
        case totalDiscount = "total_discount"
        case totalDiscountSet = "total_discount_set"
        case variantId = "variant_id"
        case variantInventoryManagement = "variant_inventory_management"
        case variantTitle = "variant_title"
        case vendor = "vendor"
        case properties
    }
    
}
