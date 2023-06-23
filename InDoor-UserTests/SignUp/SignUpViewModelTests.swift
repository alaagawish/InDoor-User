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

    
    func testPostUser(){
//        let parameters: Parameters
//        print(parameters)
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
    
    func testGetUsers(){
//        service.getData(path: Constants.customersPath, parameters: [:], handler: { [weak self] response in
//            self?.usersList = response?.customers
//        })
    }
    
    func testPutUser(){
//        let parameters: Parameters
//        service.putData(path: Constants.putUserPath, parameters: parameters, handler: { [weak self] response,code  in
//            self?.userWithDraftOrder = response?.customer
//            print("inside \(self?.userWithDraftOrder?.note)")
//        })
    }
}
