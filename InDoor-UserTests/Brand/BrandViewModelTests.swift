//
//  BrandViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 18/06/2023.
//

import XCTest
@testable import InDoor_User
final class BrandViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var brandViewModel: BrandViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        brandViewModel = BrandViewModel(netWorkingDataSource: network)
    }
    
    override func tearDownWithError() throws {
        brandViewModel = nil
        network = nil
        
    }

//    func testgetItems() {
//        brandViewModel.getItems(id: 450784461087)
//        XCTAssertNotNil(brandViewModel.result)
//        XCTAssertEqual(brandViewModel.result.count, 1)
//    }
//    
//    func testgetPrice() {
//        brandViewModel.getItems(id: 450784461087)
//        
//        brandViewModel.getPrice(i: (brandViewModel.result[0])) { product in
//            XCTAssertNotNil(product)
//            
//        }
//        
//    }
}
