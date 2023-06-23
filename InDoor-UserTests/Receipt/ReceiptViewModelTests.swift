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

   
}
