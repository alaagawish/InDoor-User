//
//  Product.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation


struct Product: Hashable, Codable {
    
    var id: Int?
    var title: String?
    var bodyHtml: String?
    var vendor: String?
    var productType: String?
    var createdAt: String?
    var handle: String?
    var updatedAt: String?
    var publishedAt: String?
    var status: String?
    var publishedScope: String?
    var tags: String?
    var adminGraphqlApiId: String?
    var variants: [Variants]?
    var options: [Options]?
    var images: [Image]?
    var image: Image?
    var templateSuffix: String?
    
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
        case templateSuffix = "template_suffix"
    }
    
    init(id: Int? = nil, title: String? = nil, bodyHtml: String? = nil, vendor: String? = nil, productType: String? = nil, createdAt: String? = nil, handle: String? = nil, updatedAt: String? = nil, publishedAt: String? = nil, status: String? = nil, publishedScope: String? = nil, tags: String? = nil, adminGraphqlApiId: String? = nil, variants: [Variants]? = nil, options: [Options]? = nil, images: [Image]? = nil, image: Image? = nil, templateSuffix: String? = nil) {
        self.id = id
        self.title = title
        self.bodyHtml = bodyHtml
        self.vendor = vendor
        self.productType = productType
        self.createdAt = createdAt
        self.handle = handle
        self.updatedAt = updatedAt
        self.publishedAt = publishedAt
        self.status = status
        self.publishedScope = publishedScope
        self.tags = tags
        self.adminGraphqlApiId = adminGraphqlApiId
        self.variants = variants
        self.options = options
        self.images = images
        self.image = image
        self.templateSuffix = templateSuffix
    }
    
    init(id: Int? , title: String?, vendor: String? , variants: [Variants]? , image: Image? ) {
        self.id = id
        self.title = title
        self.bodyHtml = nil
        self.vendor = vendor
        self.productType = nil
        self.createdAt = nil
        self.handle = nil
        self.updatedAt = nil
        self.publishedAt = nil
        self.status = nil
        self.publishedScope = nil
        self.tags = nil
        self.adminGraphqlApiId = nil
        self.variants = variants
        self.options = nil
        self.images = nil
        self.image = image
        self.templateSuffix = nil
    }
}
