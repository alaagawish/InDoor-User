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
    
    init(network: NetworkProtocol) {
        self.network = network
    }

    func putShoppingCartDraftOrder(){
        var tempArr = CartList.cartItems
        if tempArr.isEmpty {
            let lineItem = LineItems(price: "20.0", quantity: 1, title: "dummy")
            tempArr.append(lineItem)
        }
        let draftOrder = DraftOrder(id: nil, note: nil, lineItems: tempArr, user: nil)
        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: nil, draftOrder: draftOrder, orders: nil,order: nil)
        let params = JSONCoding().encodeToJson(objectClass: response)!
        network.putData(path: Constants.getCartDraftPath, parameters: params, handler: {response,code  in })
    }
    
    func getShippingCartDraftOrder(){
        print("\(UserDefault().getCustomerId())")
       if UserDefault().getCustomerId() != -1 && UserDefault().getCustomerId() != 0 {
            network.getData(path: Constants.getCartDraftPath, parameters: [:], handler: { response  in
                var lineItems = (response?.draftOrder?.lineItems)!
                for (index,lineItem) in lineItems.enumerated() {
                    if lineItem.title == "dummy" {
                        lineItems.remove(at: index)
                        break
                    }
                }
                CartList.cartItems = lineItems
            })
        }
    }
}
