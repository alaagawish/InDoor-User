//
//  ProfileViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 11/06/2023.
//

import Foundation

class ProfileViewModel {
    
    var bindOrdersToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Orders]? = [] {
        didSet{
            self.bindOrdersToViewController()
        }
    }
    init(netWorkingDataSource: NetworkProtocol) {
        
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getOrders() {
        netWorkingDataSource.getData(path: Constants.getOrdersPath, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.orders
        }
    }
    
}
