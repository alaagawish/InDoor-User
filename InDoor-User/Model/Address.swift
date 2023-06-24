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
    var `default`: Bool?
    init(id: Int?, customer_id: Int?, name: String?, first_name: String?, last_name: String?, phone: String?, address1: String?, city: String?, country: String?, `default`: Bool) {
        self.id = id
        self.customer_id = customer_id
        self.name = name
        self.first_name = first_name
        self.last_name = last_name
        self.phone = phone
        self.address1 = address1
        self.city = city
        self.country = country
        self.`default` = `default`
    }
    init(id: Int?, customer_id: Int?, `default`: Bool) {
        self.id = id
        self.customer_id = customer_id
        self.`default` = `default`
        self.name = nil
        self.first_name = nil
        self.last_name = nil
        self.phone = nil
        self.address1 = nil
        self.city = nil
        self.country = nil
    }
}
