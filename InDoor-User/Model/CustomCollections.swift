//
//  CustomCollections.swift
//  InDoor-User
//
//  Created by Alaa on 09/06/2023.
//

import Foundation
struct CustomCollections: Codable {

    let id: Int?
    let handle: String?
    let title: String?
    let updatedAt: String?
    let publishedAt: String?
    let sortOrder: String?
    let publishedScope: String?
    let adminGraphqlApiId: String?
    let image: Image?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case handle = "handle"
        case title = "title"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case publishedScope = "published_scope"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case image = "image"
    }

}
