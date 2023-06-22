//
//  Network.swift
//  InDoor-User
//
//  Created by Alaa on 03/06/2023.
//

import Foundation
import Alamofire

class Network: NetworkProtocol{
    func getData(path: String, parameters: Alamofire.Parameters, handler: @escaping (Response?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json",parameters: parameters, headers: headers).responseDecodable(of: Response.self) { response in
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
    
    func postData(path: String, parameters: Parameters,handler: @escaping (Response?,Int?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json",method: .post,parameters: parameters,encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData{ response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
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
    
    func deleteData(path: String, handler: @escaping (Response?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json", method: .delete, headers: headers).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    func putData(path: String, parameters: Parameters,handler: @escaping (Response?,Int?) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json",method: .put, parameters: parameters,encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData{ response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
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
}
