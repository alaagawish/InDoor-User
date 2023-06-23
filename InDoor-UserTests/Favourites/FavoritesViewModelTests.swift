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
    
    
    func testAddProduct(product: LocalProduct) {
//        service.insertProduct(product: product)
    }
    
    func testRemoveProduct(product: LocalProduct) {
//        service.deleteProduct(product: product)
    }
    
    func testGetAllProducts() {
//        allProductsList = service.fetchAll()
    }
    
    func testRemoveAllProduct(){
//        service.deleteAll()
    }
    
    func testCheckIfProductIsFavorite() {
//    productId: Int, customerId: Int
//        return service.isFavorite(productId: productId,customerId: customerId)
    }
    
    func testGetProduct()  {
//        let productId: Int
//        return service.fetchProduct(productId: productId)
    }
    
    func testGetRemoteProducts(){
//        let path = "products"
//        network.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
//            self?.result = response?.products ?? []
//        }
    }
    func testPutFavoriteDraftOrderFromAPI(){
//        let parameters: Parameters
//       print("path: \(Constants.putFavoriteDraftPath)")
//        network.putData(path: Constants.putFavoriteDraftPath , parameters: parameters, handler: { [weak self] response,code  in
//            self?.putFavoriteDraftOrder = response?.draftOrder
//
//        })
    }
    
    func testGetFavoriteDraftOrderFromAPI(){
//        print("path: \(Constants.putFavoriteDraftPath)")
//        network.getData(path: Constants.putFavoriteDraftPath, parameters: [:], handler: { [weak self] response in
//            self?.getFavoriteDraftOrder = response?.draftOrder
//            
//        })
    }

   

}
