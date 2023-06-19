//
//  HomeViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 04/06/2023.
//

import Foundation

class HomeViewModel{
    
    var bindResultToViewController: (()->()) = {}
    var bindDiscountToViewController: (()->()) = {}
    var bindPriceRulesToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [SmartCollections]? = [] {
        didSet{
            self.bindResultToViewController()
            
        }
    }
    
    var priceRuleDiscounts: [DiscountCodes]? = [] {
        didSet{
            self.bindDiscountToViewController()
            
        }
    }
    
    var priceRules: [PriceRule]? = [] {
        didSet{
            self.bindPriceRulesToViewController()
            
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getItems(){
        let path = Constants.smartCollections
        netWorkingDataSource.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.smartCollections
        }
    }
    
    func getAllDiscountCoupons(priceRule:PriceRule){
        let url = "price_rules/\(priceRule.id!)/discount_codes"
        netWorkingDataSource.getData(path: url, parameters: [:], handler: { discountContainer in
            self.priceRuleDiscounts = discountContainer?.discountCodes
        })
    }
    
    func getAllPriceRules(){
        let url = "price_rules"
        netWorkingDataSource.getData(path: url, parameters: [:], handler: { priceRuleCountainer in
            self.priceRules = priceRuleCountainer?.priceRules
        })
    }
}
