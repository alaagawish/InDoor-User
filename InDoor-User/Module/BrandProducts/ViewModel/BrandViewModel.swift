//
//  BrandViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 07/06/2023.
//

import Foundation


class BrandViewModel{
    var bindResultToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Product] = []  {
        didSet{
            DispatchQueue.main.async {
                self.bindResultToViewController()
            }
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
}
