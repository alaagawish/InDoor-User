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
    var usersList: [User]! = []{
        didSet{
            bindToUsersListSignUpController()
        }
    }
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func postUser(parameters: Parameters){
        service.registerUser(parameters: parameters) { [weak self] (response) in
            self?.user = response.customer
        }
    }
    
    func getUser(){
        service.getUser {[weak self] (users) in
            self?.usersList = users
        }
    }
    
}
