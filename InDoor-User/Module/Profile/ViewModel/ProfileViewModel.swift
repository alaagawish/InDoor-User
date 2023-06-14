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
    var service: DatabaseService!
    var allProductsList = [LocalProduct]()
    
    var result: [Orders]? = [] {
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.bindOrdersToViewController()
            }
        }
    }
    init(netWorkingDataSource: NetworkProtocol) {
        //        self.service = service
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getOrders() {
        netWorkingDataSource.getData(path: Constants.getOrdersPath, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.orders
        }
    }
    
}
