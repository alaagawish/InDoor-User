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
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json", headers: headers).responseDecodable(of: Response.self) { response in
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
    
    func registerUser(parameters: Parameters,handler: @escaping (Response) -> Void) {
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/customers.json",method: .post,parameters: parameters,encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 299).responseData{ response in
            switch response.result {
                case .success(let data):
                    do {
                       guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                           print("Error: Cannot convert data to JSON object")
                           return
                       }
                       guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                           print("Error: Cannot convert JSON object to Pretty JSON data")
                           return
                       }
                       guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                           print("Error: Could print JSON in String")
                           return
                       }
               
                       print(prettyPrintedJson)
                        print("before decode")
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        print("after decode \(result)")
                        handler(result)
                   } catch {
                       print("Error: Trying to convert JSON data to string")
                       return
                   }
               case .failure(let error):
                   print(error)
            }
        }
    }
    
    func getUser(handler: @escaping ([User]?) -> Void) {
        
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
