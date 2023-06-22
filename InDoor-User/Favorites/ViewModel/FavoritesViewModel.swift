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
    var bindPutFavoriteDraftOrderToController:(()->Void) = {}
    var bindGetFavoriteDraftOrderToController:(()->Void) = {}
    let defaults = UserDefaults.standard
    var putFavoriteDraftOrder: DraftOrder?{
        didSet{
            bindPutFavoriteDraftOrderToController()
        }
    }
    
    var getFavoriteDraftOrder: DraftOrder?{
        didSet{
            bindGetFavoriteDraftOrderToController()
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
       print("path: \(Constants.putFavoriteDraftPath)")
        network.putData(path: Constants.putFavoriteDraftPath , parameters: parameters, handler: { [weak self] response,code  in
            self?.putFavoriteDraftOrder = response?.draftOrder
        })
    }
    
    func getFavoriteDraftOrderFromAPI(){
        print("path: \(Constants.putFavoriteDraftPath)")
        network.getData(path: Constants.putFavoriteDraftPath, parameters: [:], handler: { [weak self] response in
            self?.getFavoriteDraftOrder = response?.draftOrder
            
        })
    }
}
