//
//  NetworkMockTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 16/06/2023.
//

import XCTest
@testable import InDoor_User

final class NetworkMockTests: XCTestCase {
    var networkMock: NetworkProtocol!
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        networkMock = nil
    }
    
    func testNetworkFail(){
        networkMock = NetworkMock(isSuccess: false)
        networkMock.getData(path: "", parameters: [:], handler: { result in
            XCTAssertNil(result)
        })
        
    }
    
    func testNetworkPass(){
        networkMock = NetworkMock(isSuccess: true)
        networkMock.getData(path: "", parameters: [:], handler: { result in
            XCTAssertNotNil(result)
        })
        
    }
    func testNetworkCurrencyPass(){
        networkMock = NetworkMock(isSuccess: true)
        networkMock.getEquivalentCurrency( handler: { result in
            XCTAssertNotNil(result)
        })
        
    }
    
    func testNetworkCurrencyFail(){
        networkMock = NetworkMock(isSuccess: false)
        networkMock.getEquivalentCurrency( handler: {result in
            XCTAssertNil(result)
            
        })
        
    }
    
    func testPostDataPass(){
        networkMock = NetworkMock(isSuccess: true)
        networkMock.postData(path: "", parameters: [:]) { response, code in
            XCTAssertNotNil(response)
            XCTAssertEqual(code, 201)
        }
        
    }
    
    
    func testPostDataFail(){
        networkMock = NetworkMock(isSuccess: false)
        networkMock.postData(path: "", parameters: [:]) { response, code in
            XCTAssertNil(response)
            XCTAssertEqual(code, 422)
        }
    }
    
    
    func testPutDataPass(){
        networkMock = NetworkMock(isSuccess: true)
        networkMock.putData(path: "", parameters: [:]) { response, code in
            XCTAssertNotNil(response)
            XCTAssertEqual(code, 201)
        }
    }
    
    
    func testPutDataFail(){
        networkMock = NetworkMock(isSuccess: false)
        networkMock.putData(path: "", parameters: [:]) { response, code in
            XCTAssertNil(response)
            XCTAssertEqual(code, 422)
        }
    }
    
    func testDeleteDataPass(){
        networkMock = NetworkMock(isSuccess: true)
        networkMock.deleteData(path: "") { response in
            XCTAssertNotNil(response)
        }
        
    }
    
    func testDeleteDataFail(){
        networkMock = NetworkMock(isSuccess: false)
        networkMock.deleteData(path: "") { response in
            XCTAssertNil(response)
        }
    }
    
    
}
