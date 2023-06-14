//
//  TotalLineItemsPriceSet.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation

struct TotalLineItemsPriceSet: Codable {

    let shopMoney: ShopMoney
    let presentmentMoney: PresentmentMoney

    private enum CodingKeys: String, CodingKey {
        case shopMoney = "shop_money"
        case presentmentMoney = "presentment_money"
    }

}
