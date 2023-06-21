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
    func getCartDraftOrder(){
        netWorkingDataSource.getData(path: Constants.getCartDraftPath, parameters: [:]) { [weak self] response in
            print("data back \(response)")
            for item in 0 ..< (response?.draftOrder?.lineItems?.count ?? 0) {
                ShoppingCartViewController.products.append(Product(id: response?.draftOrder?.lineItems?[item].productId,title: response?.draftOrder?.lineItems?[item].title, variants:[Variants(productId:response?.draftOrder?.lineItems?[item].productId,title: response?.draftOrder?.lineItems?[item].title, price: response?.draftOrder?.lineItems?[item].price ?? "" ,inventoryQuantity: response?.draftOrder?.lineItems?[item].quantity,oldInventoryQuantity: response?.draftOrder?.lineItems?[item].grams)] ,image:Image(src: response?.draftOrder?.lineItems?[item].properties?[0].value)))
            }
            
        }
    }
}
