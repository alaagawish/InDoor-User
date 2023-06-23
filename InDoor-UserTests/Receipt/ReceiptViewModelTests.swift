//
//  ReceiptViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class ReceiptViewModelTests: XCTestCase {
    
    var network: NetworkProtocol!
    var receiptViewModel: ReceiptViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        receiptViewModel = ReceiptViewModel(netWorkingDataSource: network)
        
    }
    
    override func tearDownWithError() throws {
    }
    
    func testGetAllDiscountCoupons(){
        //    priceRule:PriceRule , completionHandeler: @escaping ([DiscountCodes]) -> Void
        //        let url = "price_rules/\(priceRule.id!)/discount_codes"
        //        netWorkingDataSource.getData(path: url, parameters: [:], handler: { discountContainer in
        //            completionHandeler((discountContainer?.discountCodes!)!)
        //        })
    }
    
    func testGetAllPriceRules(){
        //completionHandeler: @escaping ([PriceRule])
        //        let url = "price_rules"
        //        netWorkingDataSource.getData(path: url, parameters: [:], handler: { priceRuleCountainer in
        //            completionHandeler((priceRuleCountainer?.priceRules!)!)
        //        })
    }
    
    func testGetSpecificPriceRule(){
        //    id: String, completionHandler: @escaping (PriceRule)
        //        let url = "price_rules/\(id)"
        //        netWorkingDataSource.getData(path: url, parameters: [:]) { priceRuleContainer in
        //            completionHandler((priceRuleContainer?.priceRule)!)
        //        }
    }
}
