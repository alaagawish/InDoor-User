//
//  DatabaseManager.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
import RealmSwift

class DatabaseManager: DatabaseService {
    static let instance = DatabaseManager()
    let realm: Realm
    private init() {
        realm = try! Realm()
    }
    
    func fetchAll() -> [LocalProduct] {
        return Array(realm.objects(LocalProduct.self))
    }
    
    func deleteAll() {
        do {
            realm.beginWrite()
            realm.deleteAll()
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteProduct(product: LocalProduct) {
        do {
            realm.beginWrite()
            realm.delete(product)
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func insertProduct(product: LocalProduct) {
        do {
            realm.beginWrite()
            realm.add(product)
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
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
