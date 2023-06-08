//
//  SmartCollections.swift
//  InDoor-User
//
//  Created by Alaa on 04/06/2023.
//

import Foundation
struct SmartCollections: Codable {

    let id: Int?
    let handle: String?
    let title: String?
    let updatedAt: String?
    let bodyHtml: String?
    let publishedAt: String?
    let sortOrder: String?
    let disjunctive: Bool?
    let rules: [Rules]?
    let publishedScope: String?
    let adminGraphqlApiId: String?
    let image: Image?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case handle = "handle"
        case title = "title"
        case updatedAt = "updated_at"
        case bodyHtml = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case disjunctive = "disjunctive"
        case rules = "rules"
        case publishedScope = "published_scope"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case image = "image"
    }

}
