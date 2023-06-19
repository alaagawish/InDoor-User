//
//  ShoppingCartViewModel.swift
//  InDoor-User
//
//  Created by Mac on 19/06/2023.
//

import Foundation

class ShoppingCartViewModel{
    
    var netWorkingDataSource: NetworkProtocol!
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getSpecificProduct(productId: Int, completionHandler:@escaping (Product) -> Void){
        let path = "products/\(productId)"
        netWorkingDataSource.getData(path: path, parameters: [:]){ (response : Response?) in
            completionHandler((response?.product)!)
        }
    }
    
    
}

