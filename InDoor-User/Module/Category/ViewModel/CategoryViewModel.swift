//
//  CategoryViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 09/06/2023.
//

import Foundation
class CategoryViewModel{
    var bindResultToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Product]? = [] {
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.bindResultToViewController()
            }
        }
    }
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getItems(id: Int) {
        
        let path = "collections/\(id)/products"
        netWorkingDataSource.getData(path: path){ [weak self] (response : Response?) in
            self?.result = response?.products
        }
    }
    
    func getPrice(i: Product, completionHandler: @escaping (Product) -> Void){
        
        netWorkingDataSource.getData(path: "products/\(i.id)") { product in
            
            completionHandler(product?.product ?? i)
        }
    }
    
}
