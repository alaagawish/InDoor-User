//
//  LocalProduct.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import Foundation
import RealmSwift

class LocalProduct: Object {
    @Persisted var id: Int?
    @Persisted var title: String?
    @Persisted var bodyHtml: String?
    @Persisted var vendor: String?
    @Persisted var productType: String?
    @Persisted var createdAt: String?
    @Persisted var handle: String?
    @Persisted var updatedAt: String?
    @Persisted var publishedAt: String?
    @Persisted var status: String?
    @Persisted var publishedScope: String?
    @Persisted var tags: String?
    @Persisted var adminGraphqlApiId: String?
//    @Persisted var variants: [Variants]?
//    @Persisted var options: [Options]?
//    @Persisted var images: [Images]?
//    @Persisted var image: Image?
    
//    convenience init(id: Int? = nil, title: String? = nil, bodyHtml: String? = nil, vendor: String? = nil, productType: String? = nil, createdAt: String? = nil, handle: String? = nil, updatedAt: String? = nil, publishedAt: String? = nil, status: String? = nil, publishedScope: String? = nil, tags: String? = nil, adminGraphqlApiId: String? = nil) {
//        self.id = id
//        self.title = title
//        self.bodyHtml = bodyHtml
//        self.vendor = vendor
//        self.productType = productType
//        self.createdAt = createdAt
//        self.handle = handle
//        self.updatedAt = updatedAt
//        self.publishedAt = publishedAt
//        self.status = status
//        self.publishedScope = publishedScope
//        self.tags = tags
//        self.adminGraphqlApiId = adminGraphqlApiId
//    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case bodyHtml = "body_html"
        case vendor = "vendor"
        case productType = "product_type"
        case createdAt = "created_at"
        case handle = "handle"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case status = "status"
        case publishedScope = "published_scope"
        case tags = "tags"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case variants = "variants"
        case options = "options"
        case images = "images"
        case image = "image"
    }
}
