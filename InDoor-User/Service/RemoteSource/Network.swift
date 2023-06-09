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
}
