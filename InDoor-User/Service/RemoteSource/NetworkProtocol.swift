//
//  NetworkProtocol.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation
import Alamofire
protocol NetworkProtocol{
    
    func getData(path: String, parameters: Alamofire.Parameters, handler: @escaping (Response?) -> Void)
    
    func getEquivalentCurrency(handler: @escaping (Response?) -> Void)
    
    func registerUser(parameters: Parameters,handler: @escaping (Response?,Int?) -> Void)
    
}
