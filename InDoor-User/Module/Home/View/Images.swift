//
//  Images.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation
struct Images: Codable {
    
    let id: Int?
    let productId: Int?
    let position: Int?
    let createdAt: String?
    let updatedAt: String?
    let width: Int?
    let height: Int?
    let src: String?
    let adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case position = "position"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width = "width"
        case height = "height"
        case src = "src"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
    
}
