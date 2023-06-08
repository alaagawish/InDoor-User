//
//  LocalProduct.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
import RealmSwift
class LocalProduct: Object {
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var status: String
    @Persisted var price: String
    @Persisted var image: String
   
    convenience init(id: Int, title: String, status: String, price: String, image: String) {
        self.init()
        self.id = id
        self.title = title
        self.status = status
        self.price = price
        self.image = image
    }
}
