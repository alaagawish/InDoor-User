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
    var bindUsersListToSignUpController:(()->Void) = {}
    var bindDraftOrderToSignUpController:(()->Void) = {}
    var bindUserWithDraftOrderToSignUpController:(()->Void) = {}
    
    var user: User?{
        didSet{
            bindUserToSignUpController()
        }
    }
    var userWithDraftOrder: User?{
        didSet{
            bindUserWithDraftOrderToSignUpController()
        }
    }
    var code: Int?
    var usersList: [User]! = []{
        didSet{
            bindUsersListToSignUpController()
        }
    }
    
    var favoritesDraftOrder: DraftOrder? {
        didSet {
            bindDraftOrderToSignUpController()
        }
    }
    var cartDraftOrder: DraftOrder? {
        didSet {
            bindDraftOrderToSignUpController()
        }
    }
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func postUser(parameters: Parameters){
        print(parameters)
        service.postData(path: Constants.customersPath ,parameters: parameters) { [weak self] (response,code) in
            self?.user = response?.customer
            self?.code = code
        }
    }
    
    func postDraftOrder(parameters: Parameters){
        service.postData(path: Constants.draftPath ,parameters: parameters) { [weak self] (response,code) in
            print("dddsasw")
            print(code)
            print(response)
            print(response?.draftOrder?.note)
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
    
    func getUsers(){
        service.getData(path: Constants.customersPath, parameters: [:], handler: { [weak self] response in
            self?.usersList = response?.customers
            
        })
    }
    
    func putUser(parameters: Parameters){
        service.putData(path: Constants.putUserPath, parameters: [:], handler: { [weak self] response,code  in
            self?.userWithDraftOrder = response?.customer
            print("inside \(self?.userWithDraftOrder?.note)")
        })
    }
    
}
