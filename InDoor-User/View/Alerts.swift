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
    
    func showRemoveProductFromFavoritesAlert(title: String, msg: String, yesHandler:@escaping (UIAlertAction)->())-> UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message:msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.yes, style: .default, handler: yesHandler))
        return alert
    }
    
    func showAlertWithNegativeAndPositiveButtons(title: String, msg: String,negativeButtonTitle: String, positiveButtonTitle: String, negativeHandler: ((UIAlertAction)->())? = nil, positiveHandler:@escaping (UIAlertAction)->())-> UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message:msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: negativeButtonTitle, style: .cancel, handler: negativeHandler))
        alert.addAction(UIAlertAction(title: positiveButtonTitle, style: .default, handler: positiveHandler))
        return alert
    }
    
    func showAlertWithPositiveButtons(title: String, msg: String, positiveButtonTitle: String, positiveHandler:((UIAlertAction)->())? = nil)-> UIAlertController{
        let alert : UIAlertController = UIAlertController(title: title, message:msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: positiveButtonTitle, style: .default, handler: positiveHandler))
        return alert
    }
}

