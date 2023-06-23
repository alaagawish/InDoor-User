//
//  PaymentViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class PaymentViewModelTests: XCTestCase {
    
    var network: NetworkProtocol!
    var paymentViewModel: PaymentViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        paymentViewModel = PaymentViewModel(netWorkingDataSource: network)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testPostOrder() {
        //        let order: Orders
        //        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: nil, draftOrder: nil, orders: nil, order: order)
        //
        //        let params = JSONCoding().encodeToJson(objectClass: response)
        //
        //        netWorkingDataSource.postData(path: Constants.ordersPath ,parameters: params ?? [:]) { [weak self] (response, code) in
        //            self?.order = response?.order
        //            self?.code = code
        //        }
    }
    
    func testDecreaseVariantCountByOrderAmount(){
        //        let items = CartList.cartItems
        //        let url = "inventory_levels/set"
        //        for item in items {
        //            var inventoryItemId = (item.properties?[0].value?.split(separator: "_")[1])!
        //            var stockCount = Int(item.properties?[0].name ?? "1") ?? 1
        //            print("inv ID \(inventoryItemId) ++++++++++ \(stockCount)")
        //            let inventoryLevel = InventoryLevel(inventoryItemId: Int(inventoryItemId), locationId: Int(Constants.location), available: (stockCount - item.quantity!))
        //            netWorkingDataSource.postData(path: url, parameters: JSONCoding().encodeToJsonFromInvLevel(objectClass: inventoryLevel)!) {[weak self] response, code in
        //              //  self?.counter += 1
        //            }
        //        }
    }
    
}
