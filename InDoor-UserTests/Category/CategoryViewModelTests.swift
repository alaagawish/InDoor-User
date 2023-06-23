//
//  CategoryViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 18/06/2023.
//

import XCTest
@testable import InDoor_User

final class CategoryViewModelTests: XCTestCase {
    
    var network: NetworkProtocol!
    var categoryViewModel: CategoryViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        categoryViewModel = CategoryViewModel(netWorkingDataSource: network)
    }
    
    override func tearDownWithError() throws {
        categoryViewModel = nil
        network = nil
        
    }
    
//    func testgetItems() {
//        categoryViewModel.getItems(id: 450784461087)
//        XCTAssertNotNil(categoryViewModel.result)
//        XCTAssertEqual(categoryViewModel.result?.count, 1)
//    }
//    
//    func testgetPrice() {
//        categoryViewModel.getItems(id: 450784461087)
//        
//        categoryViewModel.getPrice(i: (categoryViewModel.result?[0])!) { product in
//            XCTAssertNotNil(product)
//            
//        }
//        
//    }
    
}
