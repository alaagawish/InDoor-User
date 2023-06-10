//
//  DefaultAddress.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation
struct DefaultAddress: Codable {
    
    let id: Int
    let customerId: Int
    let firstName: String
    let lastName: String
    let company: String
    let address1: String
    let address2: String
    let city: String
    // let province: Any
    let country: String
    let zip: String
    let phone: String
    let name: String
    //   let provinceCode: Any
    let countryCode: String
    let countryName: String
    let defaultField: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case customerId = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company = "company"
        case address1 = "address1"
        case address2 = "address2"
        case city = "city"
        //    case province = "province"
        case country = "country"
        case zip = "zip"
        case phone = "phone"
        case name = "name"
        //   case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case defaultField = "default"
    }
}
