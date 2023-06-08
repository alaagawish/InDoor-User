//
//  LocalProduct.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
import RealmSwift
class LocalProduct: Object {
    @Persisted var id: Int?
    @Persisted var title: String?
    @Persisted var status: String?
    @Persisted var image: String?
    @Persisted var price: String?
}
