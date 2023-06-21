//
//  Image.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation

struct Image:Hashable, Codable {
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
    init(id: Int?, productId: Int?, position: Int?, createdAt: String?, updatedAt: String?, width: Int?, height: Int?, src: String?, adminGraphqlApiId: String?) {
        self.id = id
        self.productId = productId
        self.position = position
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.width = width
        self.height = height
        self.src = src
        self.adminGraphqlApiId = adminGraphqlApiId
    }
    
    init(src: String?) {
        self.id = nil
        self.productId = nil
        self.position = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.width = nil
        self.height = nil
        self.src = src
        self.adminGraphqlApiId = nil
    }
}
