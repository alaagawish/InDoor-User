//
//  DatabaseService.swift
//  InDoor-User
//
//  Created by Mac on 10/06/2023.
//

import Foundation

protocol DatabaseService {
    func fetchAll() -> [LocalProduct]
    func deleteAll()
    func deleteProduct(product: LocalProduct)
    func insertProduct(product: LocalProduct)
    func isFavorite(productId: Int) -> Bool
    func fetchProduct(productId: Int) -> LocalProduct
}
