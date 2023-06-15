//
//  Address.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import Foundation

struct Address: Codable {
    let id: Int?
    let customer_id: Int?
    let name: String?
    let first_name: String?
    let last_name: String?
    let phone: String?
    let address1: String?
    let city: String?
    let country: String?
    let `default`: Bool?
}
