//
//  Customer.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation
struct Customer: Codable {
    
    let id: Int
    let email: String?
    let acceptsMarketing: Bool?
    let createdAt: String?
    let updatedAt: String?
    let firstName: String?
    let lastName: String?
    let state: String?
    let verifiedEmail: Bool?
    let taxExempt: Bool?
    let phone: String?
    let tags: String?
    let currency: String?
    let acceptsMarketingUpdatedAt: String?
    let adminGraphqlApiId: String?
    let defaultAddress: DefaultAddress?
    
    init(id: Int, email: String?, acceptsMarketing: Bool?, createdAt: String?, updatedAt: String?, firstName: String?, lastName: String?, state: String?, verifiedEmail: Bool?, taxExempt: Bool?, phone: String?, tags: String?, currency: String?, acceptsMarketingUpdatedAt: String?, adminGraphqlApiId: String?, defaultAddress: DefaultAddress?) {
        self.id = id
        self.email = email
        self.acceptsMarketing = acceptsMarketing
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.firstName = firstName
        self.lastName = lastName
        self.state = state
        self.verifiedEmail = verifiedEmail
        self.taxExempt = taxExempt
        self.phone = phone
        self.tags = tags
        self.currency = currency
        self.acceptsMarketingUpdatedAt = acceptsMarketingUpdatedAt
        self.adminGraphqlApiId = adminGraphqlApiId
        self.defaultAddress = defaultAddress
    }
    init(id: Int) {
        self.id = id
        self.email = nil
        self.acceptsMarketing = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.firstName = nil
        self.lastName = nil
        self.state = nil
        self.verifiedEmail = nil
        self.taxExempt = nil
        self.phone = nil
        self.tags = nil
        self.currency = nil
        self.acceptsMarketingUpdatedAt = nil
        self.adminGraphqlApiId = nil
        self.defaultAddress = nil
    }
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case state = "state"
        case verifiedEmail = "verified_email"
        case taxExempt = "tax_exempt"
        case phone = "phone"
        case tags = "tags"
        case currency = "currency"
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case defaultAddress = "default_address"
    }
    
}
