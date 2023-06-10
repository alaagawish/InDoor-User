//
//  Alerts.swift
//  InDoor-User
//
//  Created by Alaa on 01/06/2023.
//

import Foundation
import UIKit


class Alert{
    
    func showChangeCurrencyAlert(title: String, msg: String, okHandler:@escaping (UIAlertAction)->())-> UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message:msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: okHandler))
        return alert
    }
}

extension Alert{
    class Constants{
        static let ok = "OK"
    }
}
