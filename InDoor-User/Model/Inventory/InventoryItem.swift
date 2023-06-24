//
//  InventoryItem.swift
//  InDoor-User
//
//  Created by Mac on 22/06/2023.
//

import Foundation

struct InventoryItem: Codable {
    
    var id: Int?
    var sku: String?
    var createdAt: String?
    var updatedAt: String?
    var requiresShipping: Bool?
    var tracked: Bool?
    var adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case sku = "sku"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case requiresShipping = "requires_shipping"
        case tracked = "tracked"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}
