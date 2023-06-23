//
//  ProductSearchViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class ProductSearchViewModelTests: XCTestCase {

    var network: NetworkProtocol!
//    var productSearchViewModel: ProductDetailsViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
//        productSearchViewModel = ProductDetailsViewModel(service: network as! DatabaseService)
    }

    override func tearDownWithError() throws {
    }
    
    func testGetItems(){
//        let path = "products"
//        networkManager.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
//            self?.result = response?.products ?? []
//        }
    }
   
}
