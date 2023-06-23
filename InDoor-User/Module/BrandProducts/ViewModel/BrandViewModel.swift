//
//  BrandViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 07/06/2023.
//

import Foundation
import Alamofire


class BrandViewModel{
    var bindResultToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    var bindPutfavoriteDraftOrderToBrandController:(()->Void) = {}
    var bindGetfavoriteDraftOrderToBrandController:(()->Void) = {}
    var putFavoriteDraftOrder: DraftOrder?{
        didSet{
            bindPutfavoriteDraftOrderToBrandController()
        }
    }
    
    var getFavoriteDraftOrder: DraftOrder?{
        didSet{
            bindGetfavoriteDraftOrderToBrandController()
        }
    }
    var result: [Product] = []  {
        didSet{
            self.bindResultToViewController()
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getItems(id: Int){
        let path = "collections/\(id)/products"
        netWorkingDataSource.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
            for i in 0 ..< (response?.products?.count ?? 0) {
                self?.getPrice(i: (response?.products?[i])!) { product in
                    print(product)
                    self?.result.append(product)
                }
            }
        }
    }
    
    func getPrice(i: Product, completionHandler: @escaping (Product) -> Void){
        netWorkingDataSource.getData(path: "products/\(i.id)", parameters: [:]) { product in
            completionHandler(product?.product ?? i)
        }
    }
    
    func putFavoriteDraftOrderFromAPI(parameters: Parameters){
        netWorkingDataSource.putData(path: "draft_orders/\(UserDefaults.standard.integer(forKey: Constants.favoritesId))", parameters: parameters, handler: { [weak self] response,code  in
            self?.putFavoriteDraftOrder = response?.draftOrder
        })
    }
    
    func getFavoriteDraftOrderFromAPI(){
        netWorkingDataSource.getData(path:  "draft_orders/\(UserDefaults.standard.integer(forKey: Constants.favoritesId))", parameters: [:], handler: { [weak self] response in
            self?.getFavoriteDraftOrder = response?.draftOrder
        })
    }
}
