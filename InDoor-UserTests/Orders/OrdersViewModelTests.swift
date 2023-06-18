//
//  OrdersViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 18/06/2023.
//

import XCTest
@testable import InDoor_User

final class OrdersViewModelTests: XCTestCase {
    
    var network: NetworkProtocol!
    var ordersViewModel: OrdersViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        ordersViewModel = OrdersViewModel(netWorkingDataSource: network)
        
    }
    
    override func tearDownWithError() throws {
        network = nil
        ordersViewModel = nil
    }
    
    func testGetOrders(){
        ordersViewModel.getOrders()
        XCTAssertNotNil(ordersViewModel.result)
        XCTAssertEqual(ordersViewModel.result?.count, 1)
    }
    
}
