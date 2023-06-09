//
//  DatabaseManager.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
import RealmSwift

protocol DatabaseService {
    func fetchAll() -> [LocalProduct]
    func deleteAll()
    func deleteProduct(product: LocalProduct)
    func insertProduct(product: LocalProduct)
    func isFavorite(productId: Int) -> Bool
    func fetchProduct(productId: Int) -> LocalProduct
}

class DatabaseManager: DatabaseService {
    static let instance = DatabaseManager()
    let realm: Realm!
    private init() {
        realm = try! Realm()
    }
    
    func fetchAll() -> [LocalProduct] {
        return Array(realm.objects(LocalProduct.self))
    }

    func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }

    func deleteProduct(product: LocalProduct) {
        realm.beginWrite()
        realm.delete(product)
        try! realm.commitWrite()
    }

    func insertProduct(product: LocalProduct) {
        realm.beginWrite()
        realm.add(product)
        try! realm.commitWrite()
    }
    
    func isFavorite(productId: Int) -> Bool {
        let allProductsList = fetchAll()
    
        for product in allProductsList {
            if(product.id == productId) {
                return true
            }
        }
        return false
    }
    
    func fetchProduct(productId: Int) -> LocalProduct {
        let allProductsList = fetchAll()
        var productObj: LocalProduct!
        for product in allProductsList {
            if(product.id == productId) {
                productObj = product
                break
            }
        }
        return productObj
    }
}
