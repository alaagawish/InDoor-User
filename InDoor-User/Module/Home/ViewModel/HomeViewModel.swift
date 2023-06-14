//
//  HomeViewModel.swift
//  InDoor-User
//
//  Created by Alaa on 04/06/2023.
//

import Foundation

class HomeViewModel{
    
    var bindResultToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [SmartCollections]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindResultToViewController()
            }
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getItems(){
        let path = Constants.smartCollections
        netWorkingDataSource.getData(path: path, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.smartCollections
        }
    }
    
    
}
