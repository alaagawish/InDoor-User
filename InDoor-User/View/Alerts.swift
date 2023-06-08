//
//  Alerts.swift
//  InDoor-User
//
//  Created by Alaa on 01/06/2023.
//

import Foundation
import UIKit

class Alert{
    
    func removeFromFav(title: String, msg: String)-> UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message:msg, preferredStyle: .alert)
      
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .cancel,handler: nil))
        
        alert.addAction(UIAlertAction(title: Constants.yes, style: .default,handler: { action in
            print("remove from realm")
            
            // remove from realm
            
        }))
        return alert
    }
}
