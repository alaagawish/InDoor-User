//
//  ShopMoney.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation
struct ShopMoney: Codable {
    
    let amount: String?
    let currencyCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currencyCode = "currency_code"
    }
    
}
