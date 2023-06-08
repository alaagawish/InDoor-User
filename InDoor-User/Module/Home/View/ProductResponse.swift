//
//  ProductResponse.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation

struct ProductResponse: Codable {
    
    let product: Product?
    
    private enum CodingKeys: String, CodingKey {
        case product = "product"
    }
    
}
