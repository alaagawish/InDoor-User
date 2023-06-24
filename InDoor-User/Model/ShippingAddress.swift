//
//  ShippingAddress.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation

struct ShippingAddress: Codable {

    let firstName: String
    let address1: String
    let phone: String
    let city: String
    let zip: String
    let country: String
    let lastName: String
    let name: String
    let countryCode: String
    

    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case address1 = "address1"
        case phone = "phone"
        case city = "city"
        case zip = "zip"
        case country = "country"
        case lastName = "last_name"
        case name = "name"
        case countryCode = "country_code"
    }

}
