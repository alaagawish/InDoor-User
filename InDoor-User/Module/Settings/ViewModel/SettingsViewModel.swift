//
//  SettingsViewModel.swift
//  InDoor-User
//
//  Created by Mac on 09/06/2023.
//

import Foundation
import Alamofire

class SettingsViewModel{
    
    var bindViewControllerToAddress: (()->()) = {}
    var bindDeleteAddressToViewController: (()->()) = {}
    var bindAddressToViewController: (()->()) = {}
    var bindUpdatedAddressToViewController: (()->()) = {}
    var netWorkingDataSource: NetworkProtocol!
    
    var address: Address?{
        didSet{
            DispatchQueue.main.async {
                self.bindViewControllerToAddress()
            }
        }
    }
    
    var deleteAddress: Address?{
        didSet{
            DispatchQueue.main.async {
                self.bindDeleteAddressToViewController()
            }
        }
    }
    
    var updateAddress: Address?{
        didSet{
            DispatchQueue.main.async {
                self.bindUpdatedAddressToViewController()
            }
        }
    }
    
    var result: [Address]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.bindAddressToViewController()
            }
        }
    }
    
    init(netWorkingDataSource: NetworkProtocol) {
        self.netWorkingDataSource = netWorkingDataSource
    }
    
    func getAddresses(){
        
        netWorkingDataSource.getData(path: Constants.addressPath, parameters: [:]){ [weak self] (response : Response?) in
            self?.result = response?.addresses
        }
    }
    
    func postAddress(parameters: Parameters){
        netWorkingDataSource.postData(path: Constants.addressPath ,parameters: parameters) { [weak self] (response, code) in
            self?.address = response?.customer_address
        }
    }
    
    func deleteAddress(path: String){
        netWorkingDataSource.deleteData(path: path) { [weak self] respose in
            self?.deleteAddress = respose?.customer_address
        }
    }
    
    func putAddress(path: String, parameters: Parameters){
        netWorkingDataSource.putData(path: path, parameters: parameters){ [weak self] (response, code) in
            self?.updateAddress = response?.customer_address
        }
    }
}
