//
//  ShoppingCartViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class ShoppingCartViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var shoppingCartViewModel: ShoppingCartViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        shoppingCartViewModel = ShoppingCartViewModel(netWorkingDataSource: network)
    }

    override func tearDownWithError() throws {
    }
    func testGetSpecificProduct(){
//        productId: Int, completionHandler:@escaping (Product) -> Void){
//        let path = "products/\(productId)"
//        netWorkingDataSource.getData(path: path, parameters: [:]){ (response : Response?) in
//            completionHandler((response?.product)!)
//        }
    }
    
   

}
