//
//  DiscountCodes.swift
//  InDoor-Admin
//
//  Created by Ahmed on 18/06/2023.
//

import Foundation

struct DiscountCodes: Codable {

    var code: String?
    var createdAt: String?
    var updatedAt: String?
    var id: Int?
    var priceRuleId: Int?
    var usageCount: Int?
    var errors: Errors?

    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id = "id"
        case priceRuleId = "price_rule_id"
        case usageCount = "usage_count"
        case errors = "errors"
    }

}
