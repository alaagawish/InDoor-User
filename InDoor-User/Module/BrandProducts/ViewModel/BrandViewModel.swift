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
        
//        let path = "collections/448450855199/products"
        let path = "collections/\(id)/products"
        
        netWorkingDataSource.getData(path: path){ [weak self] (response : Response?) in
            
            self?.result = response?.products ?? []
        }
    }
}
