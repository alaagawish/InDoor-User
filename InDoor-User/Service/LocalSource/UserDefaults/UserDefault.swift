//
//  UserDefault.swift
//  InDoor-User
//
//  Created by Alaa on 14/06/2023.
//

import Foundation

class UserDefault{
    var userDefaults: UserDefaults!
    
    init() {
        userDefaults = UserDefaults.standard
    }
    func getCustomerId() -> Int{
        
        return userDefaults.integer(forKey: Constants.customerId)
    }
}
