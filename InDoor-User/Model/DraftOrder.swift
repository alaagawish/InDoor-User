//
//  DraftOrder.swift
//  InDoor-User
//
//  Created by Mac on 19/06/2023.
//

import Foundation
struct DraftOrder: Codable {
    let id: Int?
    let note: String?
    let lineItems: [LineItems]?
    let user: User?
  //  let properties: Properties?

    enum CodingKeys: String, CodingKey {
        case id
        case note
        case lineItems = "line_items"
        case user = "customer"
    }
}
