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
    //    var productDetailsViewModel: ProductDetailsViewModel!
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        //        productDetailsViewModel = ProductDetailsViewModel(service: network as! DatabaseService)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testAddProduct() {
        //        let product: LocalProduct
        //        service.insertProduct(product: product)
    }
    
    func testRemoveProduct() {
        //        let product: LocalProduct
        //        service.deleteProduct(product: product)
    }
    
    func testCheckIfProductIsFavorite() {
        //        let productId: Int, customerId: Int
        //        return service.isFavorite(productId: productId,customerId: customerId)
    }
    
    func testGetProduct() {
        //        let productId: Int
        //        return service.fetchProduct(productId: productId)
    }
    
}
