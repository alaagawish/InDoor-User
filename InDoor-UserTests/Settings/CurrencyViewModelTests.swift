//
//  CurrencyViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class CurrencyViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var currencyViewModel: CurrencyViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        currencyViewModel = CurrencyViewModel(netWorkingDataSource: network)
    }

    override func tearDownWithError() throws {
    }

//    func testGetCurrencies(){
//        
//        netWorkingDataSource.getData(path: Constants.currencyPath, parameters: [:]){ [weak self] (response : Response?) in
//            self?.result = response?.currencies
//        }
//    }
//    
//    func testGetEquivalentCurrencies(){
//        netWorkingDataSource.getEquivalentCurrency { [weak self] (response : Response?) in
//            self?.rates = response?.rates
//        }
//    }

}
