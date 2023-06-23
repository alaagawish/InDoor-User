//
//  SignUpViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class SignUpViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var signUpViewModel: SignUpViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        signUpViewModel = SignUpViewModel(service: network)
    }

    override func tearDownWithError() throws {
    }

    

}
