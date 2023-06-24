//
//  FavoritesViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class FavoritesViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var localDatabase: DatabaseService!
    var favouritesViewModel: FavoritesViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        localDatabase = LocalSource()
        favouritesViewModel = FavoritesViewModel(service: localDatabase, network: network) 
    }

    override func tearDownWithError() throws {
    }
    
    
    func testAddProduct() {
       let product = LocalProduct(id: 1, customer_id: 12, title: "", price: "", image: "")
        favouritesViewModel.addProduct(product: product)
       
        XCTAssertNotNil(favouritesViewModel.getProduct(productId: 1))
    }
    
    func testRemoveProduct() {
        let product = LocalProduct(id: 1, customer_id: 12, title: "", price: "", image: "")
        favouritesViewModel.addProduct(product: product)
        XCTAssertEqual(favouritesViewModel.allProductsList.count, 1)
        favouritesViewModel.removeProduct(product: product)
        XCTAssertEqual(favouritesViewModel.allProductsList.count, 0)
        
    }
    
    func testGetAllProducts() {
        let product = LocalProduct(id: 1, customer_id: 12, title: "", price: "", image: "")
        favouritesViewModel.addProduct(product: product)
        favouritesViewModel.getAllProducts()
        XCTAssertEqual(favouritesViewModel.allProductsList.count, 1)
  
        
    }
    
    func testRemoveAllProduct(){
        let product = LocalProduct(id: 1, customer_id: 12, title: "", price: "", image: "")
        let product2 = LocalProduct(id: 2, customer_id: 13, title: "", price: "", image: "")
        favouritesViewModel.addProduct(product: product)
        favouritesViewModel.addProduct(product: product2)
        favouritesViewModel.getAllProducts()
        XCTAssertEqual(favouritesViewModel.allProductsList.count, 2)
        favouritesViewModel.removeAllProduct()
        favouritesViewModel.getAllProducts()
        XCTAssertEqual(favouritesViewModel.allProductsList.count, 0)
    }
    
//    func testCheckIfProductIsFavorite() {
//
//
//    }
    
    func testGetProduct()  {
        
        XCTAssertNotNil(favouritesViewModel.getProduct(productId: 8356166041887))

    }
    
    func testGetRemoteProducts(){

        favouritesViewModel.getRemoteProducts()
        XCTAssertNotNil(favouritesViewModel.result)

    }
//    func testPutFavoriteDraftOrderFromAPI(){
//
//
////        favouritesViewModel.putFavoriteDraftOrderFromAPI(parameters: param)
////        XCTAssertNotNil(favouritesViewModel.putFavoriteDraftOrder)
//
//
////        draft_orders/\(UserDefaults.standard.integer(forKey: Constants.favoritesId))
////        let parameters: Parameters
////       print("path: \(Constants.putFavoriteDraftPath)")
////        network.putData(path: Constants.putFavoriteDraftPath , parameters: parameters, handler: { [weak self] response,code  in
////            self?.putFavoriteDraftOrder = response?.draftOrder
////
////        })
//    }
    
    func testGetFavoriteDraftOrderFromAPI(){
        
        favouritesViewModel.getFavoriteDraftOrderFromAPI()
        XCTAssertNotNil(favouritesViewModel.getFavoriteDraftOrder)
    }

}
