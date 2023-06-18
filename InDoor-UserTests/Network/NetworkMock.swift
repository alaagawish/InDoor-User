//
//  NetworkMock.swift
//  InDoor-UserTests
//
//  Created by Alaa on 16/06/2023.
//

import Foundation
@testable import InDoor_User
@testable import Alamofire

class NetworkMock: NetworkProtocol{
    var isSuccess: Bool!
    init(isSuccess: Bool!) {
        self.isSuccess = isSuccess
    }
    
    let files = MockAPIFileLoader().loadApiFiles()
    let filesCurrency = MockAPIFileLoader().loadApiCurrency()
    
    func getData(path: String, parameters: Alamofire.Parameters, handler: @escaping (InDoor_User.Response?) -> Void) {
        if isSuccess{
            handler(files)
        }else{
            handler(nil)
        }
    }
    
    func getEquivalentCurrency(handler: @escaping (InDoor_User.Response?) -> Void) {
        if isSuccess{
            handler(filesCurrency)
        }else{
            handler(nil)
        }
    }
    
    func postData(path: String, parameters: Alamofire.Parameters, handler: @escaping (InDoor_User.Response?, Int?) -> Void) {
        if isSuccess{
            handler(files, 201)
        }else{
            handler(nil, 422)
        }
        
        
    }
    
    func deleteData(path: String, handler: @escaping (InDoor_User.Response?) -> Void) {
        if isSuccess{
            handler(files)
        }else{
            handler(nil)
        }
    }
    
    func putData(path: String, parameters: Alamofire.Parameters, handler: @escaping (InDoor_User.Response?, Int?) -> Void) {
        if isSuccess{
            handler(files, 201)
        }else{
            handler(nil, 422)
        }
    }
    
    
}
