//
//  ReceiptViewModel.swift
//  InDoor-User
//
//  Created by Mac on 19/06/2023.
//

import Foundation

class ReceiptViewModel{
    
    var netWorkingDataSource: NetworkProtocol!
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getAllDiscountCoupons(priceRule:PriceRule , completionHandeler: @escaping ([DiscountCodes]) -> Void ){
        let url = "price_rules/\(priceRule.id!)/discount_codes"
        netWorkingDataSource.getData(path: url, parameters: [:], handler: { discountContainer in
            completionHandeler((discountContainer?.discountCodes!)!)
        })
    }
    
    func getAllPriceRules(completionHandeler: @escaping ([PriceRule]) -> Void ){
        let url = "price_rules"
        netWorkingDataSource.getData(path: url, parameters: [:], handler: { priceRuleCountainer in
            completionHandeler((priceRuleCountainer?.priceRules!)!)
        })
    }
    
    func getSpecificPriceRule(id: String, completionHandler: @escaping (PriceRule) -> Void){
        let url = "price_rules/\(id)"
        netWorkingDataSource.getData(path: url, parameters: [:]) { priceRuleContainer in
            completionHandler((priceRuleContainer?.priceRule)!)
        }
    }
}
