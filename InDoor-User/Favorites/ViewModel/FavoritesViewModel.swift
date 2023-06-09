//
//  FavoritesViewModel.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
class FavoritesViewModel{
    var service: DatabaseService!
    var allProductsList = [LocalProduct]()
    
    init(service: DatabaseService!) {
        self.service = service
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
    
    func checkIfProductIsFavorite(productId: Int) -> Bool {
        return service.isFavorite(productId: productId)
    }
    
    func getProduct(productId: Int) -> LocalProduct {
        return service.fetchProduct(productId: productId)
    }
}
