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
    
    func getCurrencySymbol() -> String {
        return userDefaults.string(forKey: Constants.newCurrencyKey) ?? "USD"
    }
    func getCurrencyRate() -> Double {
        return userDefaults.double(forKey: Constants.ratesKey)
        
    }
    
    func getCoupon() -> String {
        return userDefaults.string(forKey: Constants.couponChosen) ?? "null"
        
    }
}
