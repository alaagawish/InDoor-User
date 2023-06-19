//
//  ProductDetailsViewModel.swift
//  InDoor-User
//
//  Created by Mac on 19/06/2023.
//

import Foundation
class ProductDetailsViewModel {
    var service: DatabaseService!
    init(service: DatabaseService) {
        self.service = service
    }
    
    func addProduct(product: LocalProduct) {
        service.insertProduct(product: product)
    }
    
    func removeProduct(product: LocalProduct) {
        service.deleteProduct(product: product)
    }
    
    func checkIfProductIsFavorite(productId: Int, customerId: Int) -> Bool {
        return service.isFavorite(productId: productId,customerId: customerId)
    }
    
    func getProduct(productId: Int) -> LocalProduct {
        return service.fetchProduct(productId: productId)
    }
}
