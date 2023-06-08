//
//  DatabaseManager.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
import RealmSwift
protocol DatabaseService{
    func fetchAll() -> [LocalProduct]
    func deleteAll()
    func deleteItem(product: LocalProduct)
    func insertItem(product: LocalProduct)
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

    func deleteItem(product: LocalProduct) {
        realm.beginWrite()
        realm.delete(product)
        try! realm.commitWrite()
    }

    func insertItem(product: LocalProduct) {
        realm.beginWrite()
        realm.add(product)
        try! realm.commitWrite()
    }
}
