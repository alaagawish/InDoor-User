//
//  GeneralViewModel.swift
//  InDoor-User
//
//  Created by Mac on 21/06/2023.
//

import Foundation
import Alamofire

class GeneralViewModel {
    
    var network:NetworkProtocol
    var productSet: Set<Product> = []
    var lineItems:[LineItems] = []
    var done = false {
        didSet{
            compareVariantsAndPrepareCartArr()
        }
    }
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func convertProductToLineItem() -> [LineItems] {
        var lineItems: [LineItems] = []
        for product in ShoppingCartViewController.products {
            for variant in product.variants! {
                let lineItem = LineItems(productId: variant.productId, quantity: variant.inventoryQuantity ,variantId: variant.id)
                lineItems.append(lineItem)
                print(lineItem)
            }
        }
        return lineItems
    }
    
    func convertLineItemsToProducts(){
        for (index, lineItem) in lineItems.enumerated() {
            getSpecificProduct(productId: lineItem.productId!) { [weak self] product in
                self?.productSet.insert(product)
                if index == (self?.lineItems.count)!-1 {
                    self?.done = true
                }
            }
        }
    }
    
    func compareVariantsAndPrepareCartArr(){
        let tempProductArr:[Product] = Array(productSet)
        ShoppingCartViewController.products = []
        for (index, product) in tempProductArr.enumerated() {
            ShoppingCartViewController.products.append(product)
            ShoppingCartViewController.products[index].variants = []
            for lineItem in lineItems {
                if lineItem.productId == tempProductArr[index].id{
                    for variant in tempProductArr[index].variants! {
                        if variant.id == lineItem.variantId {
                            var tempVariant = variant
                            tempVariant.inventoryQuantity = lineItem.quantity
                            ShoppingCartViewController.products[index].variants?.append(tempVariant)
                        }
                    }
                }
            }
        }
    }
    
    func getSpecificProduct(productId: Int, completionHandler:@escaping (Product) -> Void){
        let path = "products/\(productId)"
        network.getData(path: path, parameters: [:]){ (response : Response?) in
            completionHandler((response?.product)!)
        }
    }
    
    func putShippingCartDraftOrder(){
        let draftOrder = DraftOrder(id: nil, note: nil, lineItems: convertProductToLineItem(), user: nil)
        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: nil, draftOrder: draftOrder, orders: nil,order: nil)
        let params = JSONCoding().encodeToJson(objectClass: response)!
        network.putData(path: Constants.getCartDraftPath, parameters: params, handler: { [weak self] response,code  in
        })
    }
    
    func getShippingCartDraftOrder(){
        network.getData(path: Constants.getCartDraftPath, parameters: [:], handler: { [weak self] response  in
            self?.lineItems = (response?.draftOrder?.lineItems)!
            self?.convertLineItemsToProducts()
        })
    }}
