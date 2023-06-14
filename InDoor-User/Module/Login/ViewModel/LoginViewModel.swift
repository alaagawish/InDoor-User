//
//  LoginViewController.swift
//  InDoor-User
//
//  Created by Mac on 12/06/2023.
//

import Foundation

class LoginViewModel{
    
    var service : NetworkProtocol!
    var bindToUsersListSignUpController:(()->Void) = {}
    
    var usersList: [User]! = []{
        didSet{
            bindToUsersListSignUpController()
        }
    }
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func getUsers(){
        
        service.getData(path: Constants.customersPath, parameters: [:], handler: { [weak self] response in
            self?.usersList = response?.customers
            
        })
    }
    
}
