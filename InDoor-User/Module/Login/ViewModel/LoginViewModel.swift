//
//  LoginViewController.swift
//  InDoor-User
//
//  Created by Mac on 12/06/2023.
//

import Foundation
import Alamofire

class LoginViewModel{
    
    var service : NetworkProtocol!
    var bindToUsersListLoginController:(()->Void) = {}
    var bindUserToLoginController:(()->Void) = {}
    
    var usersList: [User]! = []{
        didSet{
            bindToUsersListLoginController()
        }
    }
    var user: User?{
        didSet{
            bindUserToLoginController()
        }
    }
    var code: Int?
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func getUsers(){
        service.getData(path: Constants.customersPath, parameters: [:], handler: { [weak self] response in
            self?.usersList = response?.customers
            
        })
    }
    
    func postUser(parameters: Parameters){
        service.postData(path: Constants.customersPath ,parameters: parameters) { [weak self] (response,code) in
            self?.user = response?.customer
            self?.code = code
        }
    }
    
}
