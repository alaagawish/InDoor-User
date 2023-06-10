//
//  Currency.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import Foundation

struct Currency: Codable {
    let currency: String?
    let rateUpdatedAt: String?
    let enabled: Bool?

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case rateUpdatedAt = "rate_updated_at"
        case enabled = "enabled"
    }
}
