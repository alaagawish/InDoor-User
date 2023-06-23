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

   

}
