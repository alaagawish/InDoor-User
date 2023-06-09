//
//  SettingsViewModel.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import Foundation

class SettingsViewModel{
    
    var bindCurrencyToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Currency]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindCurrencyToViewController()
            }
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getCurrencies(){
        let path = "currencies"
        
        netWorkingDataSource.getData(path: path){ [weak self] (response : Response?) in
            self?.result = response?.currencies
        }
    }
}
