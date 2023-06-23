//
//  ProductDetailsViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class ProductDetailsViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var productDetailsViewModel: ProductDetailsViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        productDetailsViewModel = ProductDetailsViewModel(service: network as! DatabaseService)
    }

    override func tearDownWithError() throws {
    }

    
}
