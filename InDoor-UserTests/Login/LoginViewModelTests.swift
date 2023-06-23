//
//  LoginViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class LoginViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var loginViewModel: LoginViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        loginViewModel = LoginViewModel(service: network)
    }

    override func tearDownWithError() throws {
    }

   
}
