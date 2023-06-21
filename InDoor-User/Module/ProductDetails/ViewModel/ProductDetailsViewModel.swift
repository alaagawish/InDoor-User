//
//  ProductDetailsViewModel.swift
//  InDoor-User
//
//  Created by Mac on 19/06/2023.
//

import Foundation
import Alamofire
class ProductDetailsViewModel {
    var service: DatabaseService!
    var network: NetworkProtocol!
    var bindPutCartDraftOrderToController:(()->Void) = {}
    var cartDraftOrder: DraftOrder?{
        didSet{
            bindPutCartDraftOrderToController()
        }
    }
    init(service: DatabaseService, netWorkingDataSource: NetworkProtocol) {
        self.network = netWorkingDataSource
        self.service = service
    }
    
    func addProduct(product: LocalProduct) {
        service.insertProduct(product: product)
    }
    
    func removeProduct(product: LocalProduct) {
        service.deleteProduct(product: product)
    }
    
    func checkIfProductIsFavorite(productId: Int, customerId: Int) -> Bool {
        return service.isFavorite(productId: productId,customerId: customerId)
    }
    
    func getProduct(productId: Int) -> LocalProduct {
        return service.fetchProduct(productId: productId)
    }
    
    func putShippingCartDraftOrder(parameters: Parameters){
        
        network.putData(path: Constants.getCartDraftPath, parameters: parameters, handler: { [weak self] response,code  in
            self?.cartDraftOrder = response?.draftOrder
            
        })
    }
}
