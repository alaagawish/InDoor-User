//
//  NetworkTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 16/06/2023.
//

import XCTest
@testable import InDoor_User

final class NetworkTests: XCTestCase {
    var network: NetworkProtocol!
    override func setUpWithError() throws {
        
        network = Network()
    }
    
    override func tearDownWithError() throws {
        
        network = nil
    }
    
    
//    func testGetData(){
//        
//        let myExpectation = expectation(description: "network")
//        network.getData(path: "products/8348562686239", parameters: [:]) { result in
//            guard result != nil else{
//                XCTFail()
//                myExpectation.fulfill()
//                return
//            }
//            XCTAssertNotNil(result?.product)
//            myExpectation.fulfill()
//            
//        }
//        waitForExpectations(timeout: 10)
//    }
    
    func testGetDataFail(){
        
        let myExpectation = expectation(description: "network")
        network.getData(path: "83485626", parameters: [:]) { result in
            guard result != nil else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertNil(result?.product)
            myExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testPutDataPass(){
        let address = Address(id: nil, customer_id: 7016398913823 , name: "lolo elsayedddd", first_name:"lolo", last_name:  "elsayedddd", phone: "0000-625-1199", address1: "zagazig", city: "Cairo", country: "Egypt", default: false)
        
        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: address, draftOrder: nil, orders: nil, order: nil)
        
        let params = JSONCoding().encodeToJson(objectClass: response) ?? [:]
        
        let myExpectation = expectation(description: "network")
        network.putData(path: "customers/7016398913823/addresses/9235268108575", parameters: params) { response, code in
            
            guard code ?? 0 < 400 else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertEqual(code!, 200)
            XCTAssertNotNil(response?.customer_address)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
        
    }
    
//    func testPutDataFail(){
//        let address = Address(id: nil, customer_id: 7016398913823 , name: "lolo elsayedddd", first_name:"lolo", last_name:  "elsayedddd", phone: "0000-625-1199", address1: "zagazig", city: "Cairo", country: "Cairo", default: false)
//        
//        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: address, draftOrder: nil, orders: nil, order: nil)
//        
//        let params = JSONCoding().encodeToJson(objectClass: response) ?? [:]
//        
//        let myExpectation = expectation(description: "network")
//        network.putData(path: "customers/7016398913823/addresses/9244220358943", parameters: params) { response, code in
//            
//            guard code ?? 0 < 400 else{
//                XCTAssertEqual(code!, 422)
//                myExpectation.fulfill()
//                return
//            }
//            XCTAssertEqual(code!, 200)
//            XCTAssertNotNil(response?.customer_address)
//            myExpectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 15)
//        
//    }
//    
//    func testPostDataPass(){
//
//        let address = Address(id: nil, customer_id: 7016398913823 , name: "lolo elsayedddd", first_name:"lolo", last_name:  "elsayedddd", phone: "9898-999-1111", address1: "zagazig", city: "Aswan", country: "Egypt", default: false)
//
//        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: address, draftOrder: nil, orders: nil, order: nil)
//
//        let params = JSONCoding().encodeToJson(objectClass: response) ?? [:]
//
//        let myExpectation = expectation(description: "network")
//        network.postData(path: "customers/7016398913823/addresses", parameters: params) { response, code in
//
//            guard code ?? 0 < 400 else{
//                XCTFail()
//                myExpectation.fulfill()
//                return
//            }
//            XCTAssertEqual(code!, 201)
//            XCTAssertNotNil(response?.customer_address)
//            myExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 15)
//    }
//
    func testPostDataFail(){
        let address = Address(id: nil, customer_id: 7016398913823 , name: "lolo elsayedddd", first_name:"lolo", last_name:  "elsayedddd", phone: "0000-999-1199", address1: "zagazig", city: "Aswan", country: "mmm", default: false)
        
        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: address, draftOrder: nil, orders: nil, order: nil)
        
        let params = JSONCoding().encodeToJson(objectClass: response) ?? [:]
        
        let myExpectation = expectation(description: "network")
        network.postData(path: "customers/7016398913823/addresses", parameters: params) { response, code in
            
            guard code ?? 0 < 400 else{
                XCTAssertEqual(code!, 422)
                
                myExpectation.fulfill()
                return
            }
            XCTAssertEqual(code!, 200)
            XCTAssertNotNil(response?.customer_address)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
        
    }
    func testDeleteDataPass() {
        
        let myExpectation = expectation(description: "network")
        network.deleteData(path: "customers/7016398913823/addresses/9236471644447", handler: { response in
            guard response != nil else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertNil(response?.customer_address)
            myExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 15)
        
        
    }
    
    //  func testDeleteDataFail() {
    //        let myExpectation = expectation(description: "network")
    //        network.deleteData(path: "customers/7000574820639/addresses/9233850564895", handler: { response in
    //
    //            guard response != nil else{
    //                XCTFail()
    //                myExpectation.fulfill()
    //                return
    //            }
    //            myExpectation.fulfill()
    //        })
    //
    //        waitForExpectations(timeout: 15)
    //
    //
    //    }
    
    func testGetEquivalentCurrency(){
        
        let myExpectation = expectation(description: "network")
        network.getEquivalentCurrency { response in
            guard response != nil else{
                XCTFail()
                return
            }
            XCTAssertNotNil(response)
            
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }
}
