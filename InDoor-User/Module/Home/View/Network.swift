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
        
        AF.request("https://c9bcd28dd506ef05b402c2d74ab20f13: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@mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json").responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let data):
                print("done")
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
}
