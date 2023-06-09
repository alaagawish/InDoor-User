//
//  OrdersViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import Foundation

class OrdersViewModel {
    var bindResultToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Orders]? = [] {
        didSet{
            
            self.bindResultToViewController()
            
        }
    }
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getOrders() {
        
        netWorkingDataSource.getData(path: Constants.getOrdersPath,parameters: ["status":"any"]){ [weak self] (response : Response?) in
            self?.result = response?.orders
        }
    }
    
}
