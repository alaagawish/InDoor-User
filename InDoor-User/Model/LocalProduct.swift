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
    @Persisted var customer_id: Int
    @Persisted var variant_id: Int
    @Persisted var title: String
    @Persisted var price: String
    @Persisted var image: String
   
    convenience init(id: Int, customer_id:Int,variant_id:Int, title: String, price: String, image: String) {
        self.init()
        self.id = id
        self.customer_id = customer_id
        self.variant_id = variant_id
        self.title = title
        self.price = price
        self.image = image
    }
}
