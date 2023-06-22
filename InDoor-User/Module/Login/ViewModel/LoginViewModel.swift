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
    var bindUserWithDraftOrderToController:(()->Void) = {}
    var bindDraftOrderToController:(()->Void) = {}
    var userWithDraftOrder: User?{
        didSet{
            bindUserWithDraftOrderToController()
        }
    }
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
    var favoritesDraftOrder: DraftOrder? {
        didSet {
            bindDraftOrderToController()
        }
    }
    var cartDraftOrder: DraftOrder? {
        didSet {
            bindDraftOrderToController()
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
    
    func postDraftOrder(parameters: Parameters){
        service.postData(path: Constants.draftPath ,parameters: parameters) { [weak self] (response,code) in
        
            if(response?.draftOrder?.note == "favorite"){
                self?.favoritesDraftOrder = response?.draftOrder
                print("inside \(self?.favoritesDraftOrder?.note)")
            }
            else if(response?.draftOrder?.note == "cart"){
                self?.cartDraftOrder = response?.draftOrder
                print("inside \(self?.cartDraftOrder?.note)")
            }
            self?.code = code
        }
    }
    func putUser(parameters: Parameters){
        service.putData(path: Constants.putUserPath, parameters: parameters, handler: { [weak self] response,code  in
            self?.userWithDraftOrder = response?.customer
            print("inside \(self?.userWithDraftOrder?.note)")
        })
    }
    
}
