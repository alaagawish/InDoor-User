//
//  BillingAddress.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation
struct BillingAddress: Codable {

    let firstName: String
    let address1: String
    let phone: String
    let city: String
    let zip: String
    let country: String
    let lastName: String
//    let address2: Any
//    let company: Any
//    let latitude: Any
//    let longitude: Any
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
//        case address2 = "address2"
//        case company = "company"
//        case latitude = "latitude"
//        case longitude = "longitude"
        case name = "name"
        case countryCode = "country_code"
    }

}
