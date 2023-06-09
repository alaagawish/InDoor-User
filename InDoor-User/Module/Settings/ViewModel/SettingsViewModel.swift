//
//  SettingsViewModel.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import Foundation

class SettingsViewModel{
    
    var bindCurrencyToViewController: (()->()) = {}
    var bindRatesToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var result: [Currency]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindCurrencyToViewController()
            }
        }
    }
    
    var rates: Rates? {
        didSet{
            DispatchQueue.main.async {
                self.bindRatesToViewController()
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
    
    func getEquivalentCurrencies(){
        netWorkingDataSource.getEquivalentCurrency { [weak self] (response : Response?) in
            self?.rates = response?.rates
        }
    }
}
