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
    
    func getUser(){
        service.getUser {[weak self] (users) in
            self?.usersList = users
        }
    }
    
}
