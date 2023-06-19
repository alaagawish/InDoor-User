//
//  FavoritesViewModel.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
class FavoritesViewModel{
    var service: DatabaseService!
    var network: NetworkProtocol!
    var bindallProductsListToFavoritesController:(()->Void) = {}
    var allProductsList = [LocalProduct](){
        didSet{
            bindallProductsListToFavoritesController()
        }
    }
    var bindResultToViewController: (()->()) = {}
    
    var result: [Product] = []  {
        didSet{
            self.bindResultToViewController()
        }
    }
    
    init(service: DatabaseService, network: NetworkProtocol) {
        self.service = service
        self.network = network
    }
    
    func addProduct(product: LocalProduct) {
        service.insertProduct(product: product)
    }
    
    func removeProduct(product: LocalProduct) {
        service.deleteProduct(product: product)
    }
    
    func getAllProducts() {
        allProductsList = service.fetchAll()
    }
    
    func checkIfProductIsFavorite(productId: Int, customerId: Int) -> Bool {
        return service.isFavorite(productId: productId,customerId: customerId)
    }
    
    func getProduct(productId: Int) -> LocalProduct {
        return service.fetchProduct(productId: productId)
    }
    
    func getRemoteProducts(){
        let path = "products"
        network.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.products ?? []
        }
    }
}
