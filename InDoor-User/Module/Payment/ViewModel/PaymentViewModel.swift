//
//  PaymentViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 20/06/2023.
//

import Foundation

class PaymentViewModel {
    
    var netWorkingDataSource: NetworkProtocol!
    var bindOrderToViewController: (()->()) = {}
    var code: Int?
    var generalViewModel: GeneralViewModel!
//    var counter = 0{
//        didSet {
//            if counter == allVariants.count {
//                ShoppingCartViewController.cartItems = []
//                generalViewModel.putShoppingCartDraftOrder()
//                navigate()
//            }
//
//        }
//    }
    var order: Orders?{
        didSet{
            self.bindOrderToViewController()
            
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
        self.generalViewModel = GeneralViewModel(network: netWorkingDataSource)
    }
    
    func postOrder(order: Orders) {
        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: nil, draftOrder: nil, orders: nil, order: order)
        
        let params = JSONCoding().encodeToJson(objectClass: response)

        netWorkingDataSource.postData(path: Constants.ordersPath ,parameters: params ?? [:]) { [weak self] (response, code) in
            self?.order = response?.order
            self?.code = code
        }
    }
    
    func decreaseVariantCountByOrderAmount(){
        let items = CartList.cartItems
        let url = "inventory_levels/set"
        for item in items {
            var inventoryItemId = (item.properties?[0].value?.split(separator: "_")[1])!
            var stockCount = Int(item.properties?[0].name ?? "1") ?? 1
            print("inv ID \(inventoryItemId) ++++++++++ \(stockCount)")
            let inventoryLevel = InventoryLevel(inventoryItemId: Int(inventoryItemId), locationId: Int(Constants.location), available: (stockCount - item.quantity!))
            netWorkingDataSource.postData(path: url, parameters: JSONCoding().encodeToJsonFromInvLevel(objectClass: inventoryLevel)!) {[weak self] response, code in
              //  self?.counter += 1
            }
        }
    }
}
