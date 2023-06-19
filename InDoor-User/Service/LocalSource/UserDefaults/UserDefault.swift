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
        if userDefaults.double(forKey: Constants.ratesKey) == 0 {
            return 1
        }
        return userDefaults.double(forKey: Constants.ratesKey)
        
    }
    
    func getCoupon() -> (String , String) {
        return (userDefaults.string(forKey: Constants.couponChosen) ?? "", userDefaults.string(forKey: Constants.couponType) ?? "")
    }
    
    func setCoupon(couponCode: (String , String)) {
        userDefaults.set(couponCode.0, forKey: Constants.couponChosen)
        userDefaults.set(couponCode.1, forKey: Constants.couponType)
    }
    
    func getCouponAmountAndSubtotal() -> (String , String) {
        return (userDefaults.string(forKey: Constants.discountAmount) ?? "", userDefaults.string(forKey: Constants.minSubtotal) ?? "")
    }
    
    func setCouponAmountAndSubtotal(amountAndSubTotal: (String ,String)) {
        userDefaults.set(amountAndSubTotal.0, forKey: Constants.discountAmount)
        userDefaults.set(amountAndSubTotal.1, forKey: Constants.minSubtotal)
    }
    
    func logout() {
        userDefaults.setValue(-1, forKey: Constants.customerId)
    }
}
