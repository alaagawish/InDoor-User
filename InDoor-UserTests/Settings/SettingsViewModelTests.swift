//
//  SettingsViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class SettingsViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var settingsViewModel: SettingsViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        settingsViewModel = SettingsViewModel(netWorkingDataSource: network)
        
    }

    override func tearDownWithError() throws {
    }

    
    func testGetAddresses(){
        settingsViewModel.getAddresses()
        XCTAssertNotNil(settingsViewModel.result)
       
    }
    
//    func testPostAddress(){
//        let parameters = [:]
//        settingsViewModel.postAddress(parameters: parameters)
//        XCTAssertNotNil(settingsViewModel.address)
//        XCTAssertEqual(settingsViewModel.code, 201)
//
//    }
//
//    func testDeleteAddress(){
//        let path = ""
//        settingsViewModel.deleteAddress(path: path)
//        XCTAssertNotNil(settingsViewModel.deleteAddress)
//    }
//
//    func testPutAddress(){
//        let path = ""
//        let parameters = [:]
//        settingsViewModel.putAddress(path: path, parameters: parameters)
//        XCTAssertNotNil(settingsViewModel.updateAddress)
//
//    }

}
