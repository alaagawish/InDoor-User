//
//  ProductSearchViewModel.swift
//  InDoor-User
//
//  Created by Mac on 16/06/2023.
//

import Foundation

class ProductSearchViewModel {
    
    var bindResultToViewController: (()->()) = {}
    var networkManager: NetworkProtocol!
    
    var result: [Product] = []  {
        didSet{
            self.bindResultToViewController()
        }
    }
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
    func getItems(){
        let path = "products"
        networkManager.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.products ?? []
        }
    }
}
