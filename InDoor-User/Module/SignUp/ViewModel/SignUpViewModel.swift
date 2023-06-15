//
//  SignUpViewModel.swift
//  InDoor-User
//
//  Created by Mac on 11/06/2023.
//

import Foundation
import Alamofire

class SignUpViewModel{
    
    var service : NetworkProtocol!
    var bindUserToSignUpController:(()->Void) = {}
    var bindToUsersListSignUpController:(()->Void) = {}
    
    var user: User?{
        didSet{
            bindUserToSignUpController()
        }
    }
    var code: Int?
    var usersList: [User]! = []{
        didSet{
            bindToUsersListSignUpController()
        }
    }
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func postUser(parameters: Parameters){
        service.registerUser(parameters: parameters) { [weak self] (response,code) in
            self?.user = response?.customer
            self?.code = code
        }
    }
    
    func getUsers(){
        
        service.getData(path: Constants.customersPath, parameters: [:], handler: { [weak self] response in
            self?.usersList = response?.customers
            
        })
    }
    
}
