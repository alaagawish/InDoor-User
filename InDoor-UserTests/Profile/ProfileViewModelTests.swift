//
//  ProfileViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 18/06/2023.
//

import XCTest
@testable import InDoor_User

final class ProfileViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var profileViewModel: ProfileViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        profileViewModel = ProfileViewModel(netWorkingDataSource: network)
    }

    override func tearDownWithError() throws {
        network = nil
        profileViewModel = nil
        
    }

    func testGetOrders(){
        profileViewModel.getOrders()
        XCTAssertNotNil(profileViewModel.result)
        XCTAssertEqual(profileViewModel.result?.count, 1)
    }
    

}
