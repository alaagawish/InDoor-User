//
//  Network.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation
import Alamofire

class Network: NetworkProtocol{
    func getData(path: String, handler: @escaping (Response?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path)", headers: headers).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }

    
    func getEquivalentCurrency(handler: @escaping (Response?) -> Void) {
        
        AF.request("https://api.apilayer.com/exchangerates_data/latest?apikey=k1jEDD07jaXYpHqcghG5HSqgDGFS7La0&base=USD").responseDecodable(of: Response.self) { response in
            switch response.result{
                case .success(let data):
                    handler(data)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
    
    func registerUser(parameters: Parameters,handler: @escaping (Response?,Int?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/customers.json",method: .post,parameters: parameters,encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData{ response in
            switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        print("after decode \(result)")
                        handler(result,response.response?.statusCode)
                   } catch {
                       print("Error: Trying to convert JSON data to string")
                       return
                   }
               case .failure(let error):
                print(error)
                handler(nil,error.responseCode)
            }
        }
    }
    
    func getUsers(handler: @escaping ([User]?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/customers.json",method: .get, headers: headers).responseDecodable(of: Response.self) { response in
            switch response.result {
                case .success(let data):
                handler(data.customers)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }

}
