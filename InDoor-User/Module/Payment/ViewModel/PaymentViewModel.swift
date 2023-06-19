//
//  PaymentViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 20/06/2023.
//

import Foundation

class PaymentViewModel {
    
    var bindOrderToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    var code: Int?
    
    var order: Orders?{
        didSet{
            self.bindOrderToViewController()
            
        }
    }
    
    func postOrder(order: Orders) {
        let response = Response(product: nil, products: nil, smartCollections: nil, customCollections: nil, currencies: nil, base: nil, rates: nil, customer: nil, customers: nil, addresses: nil, customer_address: nil, draftOrder: nil, orders: nil,order: order)
        
        let params = JSONCoding().encodeToJson(objectClass: response)

        netWorkingDataSource.postData(path: Constants.ordersPath ,parameters: params ?? [:]) { [weak self] (response, code) in
            self?.order = response?.order
            self?.code = code
        }
    }
}
