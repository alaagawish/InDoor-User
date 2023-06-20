//
//  FavoritesViewModel.swift
//  InDoor-User
//
//  Created by Mac on 08/06/2023.
//

import Foundation
import Alamofire
class FavoritesViewModel{
    var service: DatabaseService!
    var network: NetworkProtocol!
    var bindallProductsListToController:(()->Void) = {}
    var bindPutfavoriteDraftOrderToController:(()->Void) = {}
    var bindGetfavoriteDraftOrderToController:(()->Void) = {}
    var putFavoriteDraftOrder: DraftOrder?{
        didSet{
            bindPutfavoriteDraftOrderToController()
        }
    }
    
    var getFavoriteDraftOrder: DraftOrder?{
        didSet{
            bindGetfavoriteDraftOrderToController()
        }
    }
    var allProductsList = [LocalProduct](){
        didSet{
            bindallProductsListToController()
        }
    }
    var bindResultToViewController: (()->()) = {}
    
    var result: [Product] = []  {
        didSet{
            self.bindResultToViewController()
        }
    }
    
    init(service: DatabaseService, network: NetworkProtocol) {
        self.service = service
        self.network = network
    }
    
    func addProduct(product: LocalProduct) {
        service.insertProduct(product: product)
    }
    
    func removeProduct(product: LocalProduct) {
        service.deleteProduct(product: product)
    }
    
    func getAllProducts() {
        allProductsList = service.fetchAll()
    }
    
    func removeAllProduct(){
        service.deleteAll()
    }
    
    func checkIfProductIsFavorite(productId: Int, customerId: Int) -> Bool {
        return service.isFavorite(productId: productId,customerId: customerId)
    }
    
    func getProduct(productId: Int) -> LocalProduct {
        return service.fetchProduct(productId: productId)
    }
    
    func getRemoteProducts(){
        let path = "products"
        network.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.products ?? []
        }
    }
    func putFavoriteDraftOrderFromAPI(parameters: Parameters){
       
        network.putData(path: Constants.getFavoriteDraftPath, parameters: parameters, handler: { [weak self] response,code  in
            self?.putFavoriteDraftOrder = response?.draftOrder
           
        })
    }
    
    func getFavoriteDraftOrderFromAPI(){
      
        network.getData(path: Constants.getFavoriteDraftPath, parameters: [:], handler: { [weak self] response in
            self?.getFavoriteDraftOrder = response?.draftOrder
            
        })
    }
}
