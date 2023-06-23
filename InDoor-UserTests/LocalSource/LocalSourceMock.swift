//
//  LocalSourceMock.swift
//  InDoor-UserTests
//
//  Created by Alaa on 18/06/2023.
//

import Foundation
@testable import InDoor_User

class LocalSource: DatabaseService {
 
    
    var favouriteItems: [LocalProduct] = []
    func fetchAll() -> [LocalProduct] {
        return favouriteItems
    }
    
    func isFavorite(productId: Int, customerId: Int) -> Bool {
        let allProductsList = fetchAll()
        
        for product in allProductsList {
            if(product.id == productId && product.customer_id == customerId) {
                return true
            }
        }
        return false
    }
    
    func deleteAll() {
        favouriteItems = []
    }
    
    func deleteProduct(product: LocalProduct) {
        for i in 0 ..< favouriteItems.count {
            if favouriteItems[i] == product {
                favouriteItems.remove(at: i)
                break
            }
        }
    }
    
    func insertProduct(product: LocalProduct) {
        favouriteItems.append(product)
    }
    
    
    
    func fetchProduct(productId: Int) -> LocalProduct {
        
        var productObj: LocalProduct!
        for product in favouriteItems {
            if(product.id == productId) {
                productObj = product
                break
            }
        }
        return productObj
        
        
    }
}
