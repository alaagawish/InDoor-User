//
//  GeneralViewModel.swift
//  InDoor-User
//
//  Created by Mac on 21/06/2023.
//

import Foundation

class GeneralViewModel {
    
    var network:NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func convertProductToLineItem() -> [LineItems] {
        var lineItems: [LineItems] = []
        for product in ShoppingCartViewController.products {
            for variant in product.variants! {
                var lineItem = LineItems(productId: variant.productId, quantity: variant.inventoryQuantity ,variantId: variant.id)
                lineItems.append(lineItem)
            }
        }
        return lineItems
    }
    
    func convertLineItemsToProducts(lineItems: [LineItems]){
        for lineItem in lineItems {
            
        }
    }
}
