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

    func testGetUsers(){
//        service.getData(path: Constants.customersPath, parameters: [:], handler: { [weak self] response in
//            self?.usersList = response?.customers
//
//        })
    }
    
    func testPostUser(){
//        let parameters: Parameters
//        service.postData(path: Constants.customersPath ,parameters: parameters) { [weak self] (response,code) in
//            self?.user = response?.customer
//            self?.code = code
//        }
    }
    
    func testPostDraftOrder(){
        //        let parameters: Parameters
//        service.postData(path: Constants.draftPath ,parameters: parameters) { [weak self] (response,code) in
//
//            if(response?.draftOrder?.note == "favorite"){
//                self?.favoritesDraftOrder = response?.draftOrder
//                print("inside \(self?.favoritesDraftOrder?.note)")
//            }
//            else if(response?.draftOrder?.note == "cart"){
//                self?.cartDraftOrder = response?.draftOrder
//                print("inside \(self?.cartDraftOrder?.note)")
//            }
//            self?.code = code
//        }
    }
    func testPutUser(){
        //        let parameters: Parameters
//        service.putData(path: Constants.putUserPath, parameters: parameters, handler: { [weak self] response,code  in
//            self?.userWithDraftOrder = response?.customer
//            print("inside \(self?.userWithDraftOrder?.note)")
//        })
    }
    
}
