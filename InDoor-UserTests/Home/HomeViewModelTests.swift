//
//  HomeViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 18/06/2023.
//

import XCTest
@testable import InDoor_User

final class HomeViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var homeViewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        homeViewModel = HomeViewModel(netWorkingDataSource: network)
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
        network = nil
        
    }

    func testGetItems() {
        homeViewModel.getItems()
        XCTAssertNotNil(homeViewModel.result)
        
    }

}
